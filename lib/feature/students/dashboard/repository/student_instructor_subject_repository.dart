import '../model/student_instructor_subject_model.dart';

abstract class StudentInstructorSubjectRepository {
  Future<StudentInstructorSubjectModel> getInstructorBySubject(int subjectId);
}