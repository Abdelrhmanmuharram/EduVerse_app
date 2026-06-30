import 'package:edusync_app/feature/students/subjects/model/student_subject_instructor_model.dart';
import 'package:edusync_app/feature/students/subjects/repository/student_subject_instructor_repository.dart';

import '../data/remote/student_subject_instructor_remote_data_source.dart';

class StudentSubjectInstructorRepositoryImpl
    implements StudentSubjectInstructorRepository {
  final StudentSubjectInstructorRemoteDataSource _remoteDataSource;
  StudentSubjectInstructorRepositoryImpl(this._remoteDataSource);
  @override
  Future<List<StudentSubjectInstructorModel>> getSubjectInstructors(
    int subjectId,
  ) {
    return _remoteDataSource.getSubjectInstructors(subjectId);
  }
}
