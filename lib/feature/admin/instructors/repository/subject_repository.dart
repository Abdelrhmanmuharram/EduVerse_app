import '../../student/model/subject_model.dart';

abstract class SubjectRepository {
  Future<List<SubjectModel>> getSubjects();
}