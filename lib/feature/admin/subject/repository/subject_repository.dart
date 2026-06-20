import '../model/subjects_model.dart';

abstract class SubjectRepository {
  Future<List<SubjectsModel>> getSubjects();
}