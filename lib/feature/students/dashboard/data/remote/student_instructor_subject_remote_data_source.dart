import '../../model/student_instructor_subject_model.dart';

abstract class StudentInstructorSubjectRemoteDataSource {
  Future<StudentInstructorSubjectModel> getInstructorBySubject(int subjectId);
}