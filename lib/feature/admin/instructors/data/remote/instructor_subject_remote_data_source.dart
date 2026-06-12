import '../../model/instructor_subject_model.dart';
import '../../model/instructor_subject_upsert_model.dart';

abstract class InstructorSubjectRemoteDataSource {
  Future<List<InstructorSubjectModel>> getInstructorSubjects(String instructorId);
  Future<void> bulkUpsertSubjects(List<InstructorSubjectUpsertModel> subjects);
}
