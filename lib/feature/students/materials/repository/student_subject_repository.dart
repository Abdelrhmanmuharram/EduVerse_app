import '../model/student_subject_model.dart';

abstract class StudentSubjectRepository {
  Future<List<StudentSubjectModel>> getSubjects({
    required int yearId,
    required int semesterId,
    required int departmentId,
  });
}
