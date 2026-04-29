import 'package:dio/dio.dart';

import '../constants/api_constants.dart';
import '../services/local_storage_service.dart';

class DioClient {
  static final Dio dio =
      Dio(
          BaseOptions(
            baseUrl: APIConstants.baseUrl,
            headers: {'Content-Type': 'application/json'},
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
          ),
        )
        ..interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) async {
              final token = await LocalStorageService.getToken();
              if (token != null && !options.path.contains("/Auth/GetToken")) {
                options.headers['Authorization'] = 'Bearer $token';
              }
              print("HEADERS: ${options.headers}");
              return handler.next(options);
            },
          ),
        );
}
