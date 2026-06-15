import 'package:dio/dio.dart';
import 'package:edusync_app/core/model/user_model.dart';
import 'package:edusync_app/feature/users/data/remote/users_remote_data_source.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/dio_client.dart';
import '../../../admin/instructors/model/update_instructor_model.dart';
import '../../../admin/student/model/add_student_model.dart';
import '../../../admin/student/model/update_student_model.dart';

class UsersRemoteDataSourceImpl implements UsersRemoteDataSource {
  @override
  Future<List<UserModel>> getUsersByRole(String role) async {
    final response = await DioClient.dio.get(
      '${APIConstants.usersByRole}/$role',
    );
    final List data = response.data['data'];
    return data.map((e) => UserModel.fromJson(e)).toList();
  }

  @override
  Future<void> addStudent(AddStudentModel student) async {
    await DioClient.dio.post(APIConstants.addUser, data: student.toJson());
  }

  @override
  Future<void> updateStudent(UpdateStudentModel student) async {
    await DioClient.dio.put(APIConstants.updateProfile, data: student.toJson());
  }

  @override
  Future<void> updateInstructor(UpdateInstructorModel instructor) async {
    try {
      final response = await DioClient.dio.put(
        '${APIConstants.baseUrl}${APIConstants.updateProfile}',
        data: instructor.toJson(),
      );
    } on DioException catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> reactivateAccount(String userId) async {
    await DioClient.dio.post(
      '${APIConstants.baseUrl}/Users/reactivateAccount',
      data: {
        'userId': userId,
      }
    );
  }

  @override
  Future<void> deactivateAccount(String userId) async {
    await DioClient.dio.post(
      '${APIConstants.baseUrl}/Users/deactivateAccount',
      data: {
        'userId': userId,
      }
    );
  }

  @override
  Future<void> deleteUsers(String userId) async {
    await DioClient.dio.delete(
      '${APIConstants.baseUrl}/Users/$userId',
    );
  }
}
