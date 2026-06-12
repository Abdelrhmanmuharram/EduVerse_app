import 'package:edusync_app/core/model/user_model.dart';

import '../../../admin/instructors/model/update_instructor_model.dart';
import '../../../admin/student/model/add_student_model.dart';
import '../../../admin/student/model/update_student_model.dart';

abstract class UsersRemoteDataSource {
  Future<List<UserModel>> getUsersByRole(String role);
  Future<void> updateStudent(UpdateStudentModel student);
  Future<void> addStudent(AddStudentModel student);
  Future<void> updateInstructor(UpdateInstructorModel instructor);
}
