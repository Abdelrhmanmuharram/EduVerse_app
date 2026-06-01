import 'package:dio/dio.dart';

import 'api_exception.dart';

class DioErrorHandler {
  static ApiException handle(DioException e) {
    final data = e.response?.data;
    if (data is Map<String, dynamic>) {
      final message = data['message'];
      switch (message) {
        case 'NotDeletedMessage':
          return ApiException(
            'This item cannot be deleted because it is currently in use.',
          );
        case 'NotFoundMessage':
          return ApiException('The requested item was not found.');
        default:
          return ApiException(message?.toString() ?? 'Something went wrong.');
      }
    }
    return ApiException('Network error occurred.');
  }
}
