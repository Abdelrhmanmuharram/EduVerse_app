import 'package:dio/dio.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/network/dio_client.dart';
import '../model/login_model.dart';

class LoginRepository {
  Future<LoginModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await DioClient.dio.post(
        APIConstants.login,
        data: {"email": email, "password": password},
      );
      final data = response.data;
      if (data['success'] == false) {
        String errorMessage = data['message'];

        if (data['errors'] != null &&
            data['errors'] is Map<String, dynamic> &&
            data['errors']['message'] != null) {
          errorMessage = data['errors']['message'];
        }
        throw Exception(data['errors']?['message'] ?? data['message']);
      }
      return LoginModel.fromJson(data);
    } on DioException catch (e) {
      String errorMessage = "Something went wrong";
      if (e.response != null) {
        final data = e.response!.data;
        if (data is Map<String, dynamic>) {
          if (data['errors'] != null && data['errors'] is Map) {
            final errors = data['errors'] as Map<String, dynamic>;

            for (var value in errors.values) {
              if (value is String && value.isNotEmpty) {
                errorMessage = value;
                break;
              } else if (value is List && value.isNotEmpty) {
                errorMessage = value.first.toString();
                break;
              }
            }
          } else {
            errorMessage = data['message'] ?? errorMessage;
          }
        }
      } else {
        errorMessage = "Check your internet connection";
      }
      throw Exception(errorMessage);
    }
  }
}
