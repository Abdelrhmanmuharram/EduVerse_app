import '../../../student/model/subject_model.dart';
import '../../model/instructor_subject_upsert_model.dart';

abstract class SubjectRemoteDataSource {
  Future<List<SubjectModel>> getSubjects();
  Future<void> bulkUpsertSubjects(List<InstructorSubjectUpsertModel> subjects);
}
