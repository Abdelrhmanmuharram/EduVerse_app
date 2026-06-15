import 'package:edusync_app/core/model/user_model.dart';
import 'package:edusync_app/feature/admin/instructors/model/update_instructor_model.dart';
import 'package:edusync_app/feature/users/repository/users_repository.dart';

import '../../admin/student/model/add_student_model.dart';
import '../../admin/student/model/update_student_model.dart';
import '../data/remote/users_remote_data_source.dart';

class UsersRepositoryImpl implements UsersRepository {
  final UsersRemoteDataSource remoteDataSource;
  UsersRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<UserModel>> getUsersByRole(String role) {
    return remoteDataSource.getUsersByRole(role);
  }

  @override
  Future<void> addStudent(AddStudentModel student) {
    return remoteDataSource.addStudent(student);
  }

  @override
  Future<void> updateStudent(UpdateStudentModel student) {
    return remoteDataSource.updateStudent(student);
  }

  @override
  Future<void> updateInstructor(UpdateInstructorModel instructor) async {
    await remoteDataSource.updateInstructor(instructor);
  }

  @override
  Future<void> reactivateAccount(String userId) async {
    await remoteDataSource.reactivateAccount(userId);
  }

  @override
  Future<void> deactivateAccount(String userId) async {
    await remoteDataSource.deactivateAccount(userId);
  }

  @override
  Future<void> deleteUsers(String userId) async {
    await remoteDataSource.deleteUsers(userId);
  }
}
