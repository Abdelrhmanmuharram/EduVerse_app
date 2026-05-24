import 'package:dio/dio.dart';

import '../../../core/constants/api_constants.dart';

class InstructorRepository {
  final Dio dio = Dio();
  Future<Response> addInstructor({
    required String email,
    required String fullName,
    required String password,
    required int departmentId,
  }) async {
    try {
      final response = await dio.post(
        '${APIConstants.baseUrl}${APIConstants.addUser}/Instructor',
        data: {
          "email": email,
          "fullName": fullName,
          "password": password,
          "departmentId": departmentId,
        },
      );
      print(response.data);
      return response;
    } on DioException catch (e) {
      print(e.response?.data);
      print(e.response?.statusCode);
      rethrow;
    }
  }

}
