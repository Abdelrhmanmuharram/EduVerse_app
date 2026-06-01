import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/cupertino.dart';
import '../constants/api_constants.dart';
import '../services/local_storage_service.dart';
import '../services/navigation_service.dart';

class DioClient {
  static final CookieJar cookieJar = CookieJar();

  /// Buffer before actual expiry to refresh proactively (avoids edge cases)
  static const _expiryBuffer = Duration(seconds: 30);

  // ─── Separate Dio instance ONLY for refresh calls ───────────────────────────
  // Avoids triggering the main interceptor recursively.
  static final Dio _refreshDio = Dio(
    BaseOptions(
      baseUrl: APIConstants.baseUrl,
      headers: {'Content-Type': 'application/json'},
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  )..interceptors.add(CookieManager(cookieJar));

  // ─── Main Dio instance ──────────────────────────────────────────────────────
  static final Dio dio =
      Dio(
          BaseOptions(
            baseUrl: APIConstants.baseUrl,
            headers: {'Content-Type': 'application/json'},
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
          ),
        )
        ..interceptors.add(CookieManager(cookieJar))
        ..interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) async {
              // Skip all token logic for the login endpoint
              if (options.path.contains('/Auth/GetToken')) {
                return handler.next(options);
              }

              // ── Step 1: check if refresh token itself is expired ────────────────
              final refreshExpiry =
                  await LocalStorageService.getRefreshTokenExpiry();
              final now = DateTime.now().toUtc();

              if (refreshExpiry != null && now.isAfter(refreshExpiry)) {
                // Both tokens are dead — force logout immediately, no point sending
                debugPrint('Refresh token expired — forcing logout.');
                await LocalStorageService.clearUserData();
                // TODO: navigate to login, e.g. NavigationService.navigateTo('/login');
                NavigationService.pushReplacementNamed('/login');
                return handler.reject(
                  DioException(
                    requestOptions: options,
                    error: 'Session expired. Please log in again.',
                    type: DioExceptionType.cancel,
                  ),
                );
              }

              // ── Step 2: check if access token is expired (with buffer) ──────────
              final tokenExpiry = await LocalStorageService.getTokenExpiry();
              final accessTokenExpired =
                  tokenExpiry == null ||
                  now.isAfter(tokenExpiry.subtract(_expiryBuffer));

              if (accessTokenExpired) {
                debugPrint(
                  'Access token expired or expiring soon — refreshing proactively...',
                );
                final newToken = await _refreshAccessToken();
                if (newToken != null) {
                  options.headers['Authorization'] = 'Bearer $newToken';
                  return handler.next(options);
                } else {
                  // Refresh failed — stop the request
                  await LocalStorageService.clearUserData();
                  // TODO: navigate to login
                  NavigationService.pushReplacementNamed('/login');
                  return handler.reject(
                    DioException(
                      requestOptions: options,
                      error: 'Token refresh failed. Please log in again.',
                      type: DioExceptionType.cancel,
                    ),
                  );
                }
              }

              // ── Step 3: access token is still valid — attach it normally ─────────
              final token = await LocalStorageService.getToken();
              if (token != null) {
                options.headers['Authorization'] = 'Bearer $token';
              }
              return handler.next(options);
            },

            onError: (DioException error, handler) async {
              // Safety net: handles 401s from clock skew or server-side revocation
              // that slipped past the proactive check above.
              if (error.response?.statusCode == 401) {
                debugPrint('401 received — attempting emergency token refresh...');
                final newToken = await _refreshAccessToken();
                if (newToken != null) {
                  debugPrint('Token refreshed — retrying original request...');
                  final opts = error.requestOptions;
                  opts.headers['Authorization'] = 'Bearer $newToken';
                  try {
                    final retryResponse = await dio.fetch(opts);
                    return handler.resolve(retryResponse);
                  } catch (retryError) {
                    debugPrint('Retry after refresh failed: $retryError');
                  }
                }
                debugPrint('Emergency refresh failed — clearing tokens.');
                await LocalStorageService.clearUserData();
                // TODO: navigate to login
                NavigationService.pushReplacementNamed('/login');
              }
              return handler.next(error);
            },
          ),
        );

  // ─── Token refresh using isolated _refreshDio ───────────────────────────────
  static Future<String?> _refreshAccessToken() async {
    try {
      final refreshToken = await LocalStorageService.getRefreshToken();
      if (refreshToken == null) {
        debugPrint('No refresh token found in storage.');
        return null;
      }

      // Backend expects the refresh token as a cookie named "RefreshToken"
      _refreshDio.options.headers['Cookie'] = 'RefreshToken=$refreshToken';

      final response = await _refreshDio.get(APIConstants.refreshToken);
      if (response.statusCode == 200 && response.data['success'] == true) {
        final data = response.data['data'];
        final newAccessToken = data['accessToken'] as String;
        final newRefreshToken = data['refreshToken'] as String;
        final newAccessExpiry = data['expiresIn'] as String;
        final newRefreshExpiry = data['refreshTokenExpiration'] as String;

        await LocalStorageService.saveToken(newAccessToken);
        await LocalStorageService.saveTokenExpiry(newAccessExpiry);
        await LocalStorageService.saveRefreshToken(newRefreshToken);
        await LocalStorageService.saveRefreshTokenExpiry(newRefreshExpiry);

        debugPrint('All tokens and expiry dates updated successfully.');
        return newAccessToken;
      } else {
        debugPrint('Refresh endpoint returned failure: ${response.data}');
        return null;
      }
    } catch (e) {
      debugPrint('Exception during token refresh: $e');
      return null;
    }
  }
}
