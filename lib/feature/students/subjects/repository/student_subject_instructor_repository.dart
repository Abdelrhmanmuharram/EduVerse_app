import '../model/student_subject_instructor_model.dart';

abstract class StudentSubjectInstructorRepository {
  Future<List<StudentSubjectInstructorModel>> getSubjectInstructors(int subjectId);
}