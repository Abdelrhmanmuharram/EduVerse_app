import 'package:edusync_app/feature/admin/instructors/repository/subject_repository.dart';

import '../../student/model/subject_model.dart';
import '../data/remote/subject_remote_data_source.dart';

class SubjectRepositoryImpl implements SubjectRepository {
  final SubjectRemoteDataSource remoteDataSource;
  SubjectRepositoryImpl(this.remoteDataSource);
  @override
  Future<List<SubjectModel>> getSubjects() {
    return remoteDataSource.getSubjects();
  }
}
