import 'package:edusync_app/feature/admin/semesters/model/semester_model.dart';
import 'package:edusync_app/feature/admin/semesters/repository/semester_repository.dart';

import '../data/remote/semester_remote_data_source.dart';

class SemesterRepositoryImpl implements SemesterRepository {
  final SemesterRemoteDataSource _remoteDataSource;
  SemesterRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<SemesterModel>> getSemesters() {
    return _remoteDataSource.getSemesters();
  }

  @override
  Future<void> addSemester(SemesterModel semester) {
    return _remoteDataSource.addSemester(semester);
  }

  @override
  void editSemester(int index, SemesterModel semester) {
    throw UnimplementedError();
  }

  @override
  void deleteSemester(SemesterModel semester) {
    throw UnimplementedError();
  }
}
