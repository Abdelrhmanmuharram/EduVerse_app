import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

import '../constants/api_constants.dart';
import '../services/local_storage_service.dart';

class DioClient {
  static final CookieJar cookieJar = CookieJar();

  static const _expiryBuffer = Duration(seconds: 30);
  static bool _isRefreshing = false;
  static Future<String?>? _refreshFuture;

  static final Dio _refreshDio = Dio(
    BaseOptions(
      baseUrl: APIConstants.baseUrl,
      headers: {'Content-Type': 'application/json'},
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  )..interceptors.add(CookieManager(cookieJar));

  static final Dio dio = Dio(
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

          final refreshExpiry = await LocalStorageService.getRefreshTokenExpiry();
          final now = DateTime.now().toUtc();

          if (refreshExpiry != null && now.isAfter(refreshExpiry)) {
            print('Refresh token expired — forcing logout.');
            await LocalStorageService.clearUserData();
            // TODO: navigate to login, e.g. NavigationService.navigateTo('/login');
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
            print('Access token expired or expiring soon — refreshing...');
            final newToken = await _getRefreshLocked();

            if (newToken != null) {
              options.headers['Authorization'] = 'Bearer $newToken';
              return handler.next(options);
            } else {
              await LocalStorageService.clearUserData();
              // TODO: navigate to login
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
            print('401 received — attempting emergency token refresh...');

            final newToken = await _getRefreshLocked();
            if (newToken != null) {
              print('Token refreshed — retrying original request...');
              final opts = error.requestOptions;
              opts.headers['Authorization'] = 'Bearer $newToken';
              try {
                final retryResponse = await dio.fetch(opts);
                return handler.resolve(retryResponse);
              } catch (retryError) {
                print('Retry after refresh failed: $retryError');
              }
            }

            print('Emergency refresh failed — clearing tokens.');
            await LocalStorageService.clearUserData();
            // TODO: navigate to login
          }
          return handler.next(error);
        },
      ),
    );
  static Future<String?> _getRefreshLocked() {
    if (_isRefreshing && _refreshFuture != null) {
      print('Refresh already in progress — waiting for it...');
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
        print('No refresh token found in storage.');
        return null;
      }

      _refreshDio.options.headers['Cookie'] = 'RefreshToken=$refreshToken';

      final response = await _refreshDio.get('/api/Auth/refreshToken');

      if (response.statusCode == 200 && response.data['success'] == true) {
        final data = response.data['data'];

        await LocalStorageService.saveToken(data['accessToken'] as String);
        await LocalStorageService.saveTokenExpiry(data['expiresIn'] as String);
        await LocalStorageService.saveRefreshToken(data['refreshToken'] as String);
        await LocalStorageService.saveRefreshTokenExpiry(data['refreshTokenExpiration'] as String);

        print('All tokens and expiry dates updated successfully.');
        return data['accessToken'] as String;
      } else {
        print('Refresh endpoint returned failure: ${response.data}');
        return null;
      }
    } catch (e) {
      print('Exception during token refresh: $e');
      return null;
    }
  }
}