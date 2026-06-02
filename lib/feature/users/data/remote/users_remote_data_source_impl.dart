import 'package:edusync_app/core/model/user_model.dart';
import 'package:edusync_app/feature/users/data/remote/users_remote_data_source.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/dio_client.dart';
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
  Future<void> updateStudent(UpdateStudentModel student) async {
    await DioClient.dio.put(APIConstants.updateProfile, data: student.toJson());
  }
}
