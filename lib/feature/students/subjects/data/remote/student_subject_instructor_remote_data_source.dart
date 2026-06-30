import 'package:edusync_app/feature/students/subjects/model/student_subject_instructor_model.dart';

abstract class StudentSubjectInstructorRemoteDataSource {
  Future<List<StudentSubjectInstructorModel>> getSubjectInstructors(int subjectId);
}