import 'package:dio/dio.dart';
import 'package:edusync_app/core/network/dio_client.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/model/user_model.dart';

class InstructorRepository {
  final Dio dio = Dio();
  Future<String> addInstructor({
    required String email,
    required String fullName,
    required String password,
    required int? departmentId,
  }) async {
    try {
      final response = await DioClient.dio.post(
        '${APIConstants.baseUrl}${APIConstants.addUser}/Instructor',
        data: {
          "email": email,
          "fullName": fullName,
          "password": password,
          "departmentId": departmentId,
        },
      );
      print("ADD RESPONSE = ${response.data}");
      return response.data['data']['id'];
    } on DioException catch (e) {
      print("ADD ERROR = ${e.response?.data}");
      print("ADD STATUS = ${e.response?.statusCode}");
      rethrow;
    }
  }

  Future<List<UserModel>> getUsersByRole(String role) async {
    try {
      final response = await dio.get(
        '${APIConstants.baseUrl}${APIConstants.usersByRole}',
      );
      final List users = response.data['data'];
      return users
          .map((e) => UserModel.fromJson(e))
          .where((user) => user.roles.contains(role))
          .toList();
    } on DioException catch (e) {
      print(e.response?.data);
      print(e.response?.statusCode);
      rethrow;
    }
  }
}
