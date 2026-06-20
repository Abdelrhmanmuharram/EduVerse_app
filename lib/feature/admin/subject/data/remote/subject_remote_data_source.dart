import 'package:edusync_app/feature/admin/student/model/subject_model.dart';

abstract class SubjectsRemoteDataSource {
  Future<List<SubjectModel>> getSubjects();
}