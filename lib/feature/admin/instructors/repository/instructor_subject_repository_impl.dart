import '../data/remote/instructor_subject_remote_data_source.dart';
import '../model/instructor_subject_model.dart';
import '../model/instructor_subject_upsert_model.dart';
import 'instructor_subject_repository.dart';

class InstructorSubjectRepositoryImpl implements InstructorSubjectRepository {
  final InstructorSubjectRemoteDataSource remoteDataSource;

  InstructorSubjectRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<InstructorSubjectModel>> getInstructorSubjects(String instructorId) async {
    return remoteDataSource.getInstructorSubjects(instructorId);
  }

  @override
  Future<void> bulkUpsertSubjects(
    List<InstructorSubjectUpsertModel> subjects,
  ) async {
    await remoteDataSource.bulkUpsertSubjects(subjects);
  }

  @override
  Future<void> deleteInstructorSubject(int id) async {
    await remoteDataSource.deleteInstructorSubject(id);
  }
}
