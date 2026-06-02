import 'package:edusync_app/core/model/user_model.dart';

import '../../../admin/student/model/update_student_model.dart';

abstract class UsersRemoteDataSource {
  Future<List<UserModel>> getUsersByRole(String role);
  Future<void> updateStudent(UpdateStudentModel student);
}
