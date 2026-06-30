import '../../model/student_subject_model.dart';

abstract class StudentSubjectRemoteDataSource {
  Future<List<StudentSubjectModel>> getSubjects({
    required int yearId,
    required int semesterId,
    required int departmentId,
  });
}
