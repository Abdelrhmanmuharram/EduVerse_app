import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';

import '../../feature/auth/login/view/login_view.dart';
import '../constants/api_constants.dart';
import '../services/local_storage_service.dart';

class DioClient {
  static final CookieJar cookieJar = CookieJar();

  static const _expiryBuffer = Duration(seconds: 30);
  static bool _isRefreshing = false;
  static Future<String?>? _refreshFuture;

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static void _goToLogin() {
    navigatorKey.currentState?.pushNamedAndRemoveUntil(
      LoginView.routeName,
      (route) => false,
    );
  }

  static final Dio _refreshDio = Dio(
    BaseOptions(
      baseUrl: APIConstants.baseUrl,
      headers: {'Content-Type': 'application/json'},
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );
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
              if (options.path.contains('/Auth/GetToken')) {
                return handler.next(options);
              }
              final refreshExpiry =
                  await LocalStorageService.getRefreshTokenExpiry();
              final now = DateTime.now().toUtc();

              if (refreshExpiry != null && now.isAfter(refreshExpiry)) {
                debugPrint('Refresh token expired — forcing logout.');
                await LocalStorageService.clearUserData();
                _goToLogin();
                return handler.reject(
                  DioException(
                    requestOptions: options,
                    error: 'Session expired. Please log in again.',
                    type: DioExceptionType.cancel,
                  ),
                );
              }
              final tokenExpiry = await LocalStorageService.getTokenExpiry();
              final accessTokenExpired =
                  tokenExpiry == null ||
                  now.isAfter(tokenExpiry.subtract(_expiryBuffer));

              if (accessTokenExpired) {
                debugPrint('Access token expired — refreshing proactively...');
                final newToken = await _getRefreshLocked();

                if (newToken != null) {
                  options.headers['Authorization'] = 'Bearer $newToken';
                  return handler.next(options);
                } else {
                  await LocalStorageService.clearUserData();
                  _goToLogin();
                  return handler.reject(
                    DioException(
                      requestOptions: options,
                      error: 'Token refresh failed. Please log in again.',
                      type: DioExceptionType.cancel,
                    ),
                  );
                }
              }
              final token = await LocalStorageService.getToken();
              if (token != null) {
                options.headers['Authorization'] = 'Bearer $token';
              }
              return handler.next(options);
            },
            onError: (DioException error, handler) async {
              if (error.response?.statusCode == 401) {
                debugPrint('401 received — emergency token refresh...');
                final newToken = await _getRefreshLocked();
                if (newToken != null) {
                  final opts = error.requestOptions;
                  opts.headers['Authorization'] = 'Bearer $newToken';
                  try {
                    final retryResponse = await dio.fetch(opts);
                    return handler.resolve(retryResponse);
                  } catch (retryError) {
                    debugPrint('Retry after refresh failed: $retryError');
                  }
                }
                await LocalStorageService.clearUserData();
                _goToLogin();
              }
              return handler.next(error);
            },
          ),
        );
  static Future<String?> _getRefreshLocked() {
    if (_isRefreshing && _refreshFuture != null) {
      debugPrint('Refresh already in progress — waiting...');
      return _refreshFuture!;
    }
    _isRefreshing = true;
    _refreshFuture = _refreshAccessToken().whenComplete(() {
      _isRefreshing = false;
      _refreshFuture = null;
    });
    return _refreshFuture!;
  }

  static Future<String?> _refreshAccessToken() async {
    try {
      final refreshToken = await LocalStorageService.getRefreshToken();
      if (refreshToken == null) {
        debugPrint('No refresh token in storage.');
        return null;
      }
      debugPrint(
        'Calling refresh: ${APIConstants.baseUrl}${APIConstants.refreshToken}',
      );
      final response = await _refreshDio.get(
        APIConstants.refreshToken,
        options: Options(headers: {'Cookie': 'RefreshToken=$refreshToken'}),
      );
      debugPrint('Refresh status: ${response.statusCode}');
      debugPrint('Refresh body: ${response.data}');
      if (response.statusCode == 200 && response.data['success'] == true) {
        final data = response.data['data'];
        await LocalStorageService.saveToken(data['accessToken'] as String);
        await LocalStorageService.saveTokenExpiry(data['expiresIn'] as String);
        await LocalStorageService.saveRefreshToken(
          data['refreshToken'] as String,
        );
        await LocalStorageService.saveRefreshTokenExpiry(
          data['refreshTokenExpiration'] as String,
        );
        debugPrint('Tokens refreshed successfully.');
        return data['accessToken'] as String;
      } else {
        debugPrint('Refresh failed: ${response.data}');
        return null;
      }
    } catch (e) {
      debugPrint('Exception during token refresh: $e');
      return null;
    }
  }
}
