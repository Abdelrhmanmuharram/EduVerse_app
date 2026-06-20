import 'package:edusync_app/feature/admin/student/model/subject_model.dart';

import '../../instructors/repository/subject_repository.dart';
import '../data/remote/subject_remote_data_source.dart';

class SubjectRepositoryImpl implements SubjectRepository {
  final SubjectsRemoteDataSource _remoteDataSource;
  SubjectRepositoryImpl(this._remoteDataSource);
  @override
  Future<List<SubjectModel>> getSubjects() {
    return _remoteDataSource.getSubjects();
  }
}
