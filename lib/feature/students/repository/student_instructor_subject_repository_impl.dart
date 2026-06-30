import 'package:edusync_app/feature/students/repository/student_instructor_subject_repository.dart';

import '../data/remote/student_instructor_subject_remote_data_source.dart';
import '../model/student_instructor_subject_model.dart';

class StudentInstructorSubjectRepositoryImpl
    implements StudentInstructorSubjectRepository {
  final StudentInstructorSubjectRemoteDataSource _remote;
  StudentInstructorSubjectRepositoryImpl(this._remote);
  @override
  Future<StudentInstructorSubjectModel> getInstructorBySubject(int subjectId) {
    return _remote.getInstructorBySubject(subjectId);
  }
}
