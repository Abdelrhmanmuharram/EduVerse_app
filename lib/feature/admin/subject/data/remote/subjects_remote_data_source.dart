import '../../model/subjects_model.dart';

abstract class SubjectsRemoteDataSource {
  Future<List<SubjectsModel>> getSubjects();
  Future<void> addSubject(SubjectsModel subject);
  Future<void> updateSubject(int id,SubjectsModel subject);
  Future<void> deleteSubject(int id);
  Future<String> getNextCode();
}