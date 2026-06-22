import 'package:edusync_app/feature/admin/student/model/subject_model.dart';

import '../data/remote/subjects_remote_data_source.dart';
import '../model/subjects_model.dart';
import 'subjects_repository.dart';

class SubjectsRepositoryImpl implements SubjectsRepository {
  final SubjectsRemoteDataSource _remoteDataSource;
  SubjectsRepositoryImpl(this._remoteDataSource);
  @override
  Future<List<SubjectsModel>> getSubjects() {
    return _remoteDataSource.getSubjects();
  }

  @override
  Future<void> addSubject(SubjectsModel subject) {
    return _remoteDataSource.addSubject(subject);
  }

  @override
  Future<void> deleteSubject(int id) {
    return _remoteDataSource.deleteSubject(id);
  }

  @override
  Future<void> updateSubject(int id, SubjectsModel subject) {
    return _remoteDataSource.updateSubject(id, subject);
  }

  @override
  Future<String> getNextCode() {
    return _remoteDataSource.getNextCode();
  }
}
