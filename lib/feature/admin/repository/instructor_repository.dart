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
    return await dio.post(
      '${APIConstants.baseUrl}${APIConstants.addUser}/instructor',
      data: {
        "email": email,
        "fullName": fullName,
        "password": password,
        "departmentId": departmentId,
      },
    );
  }
}