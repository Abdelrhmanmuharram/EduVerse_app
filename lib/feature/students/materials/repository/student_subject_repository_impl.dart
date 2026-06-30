import 'package:edusync_app/feature/students/materials/repository/student_subject_repository.dart';
import '../data/remote/student_subject_remote_data_source.dart';
import '../model/student_subject_model.dart';

class StudentSubjectRepositoryImpl implements StudentSubjectRepository {
  final StudentSubjectRemoteDataSource remoteDataSource;
  StudentSubjectRepositoryImpl({required this.remoteDataSource});
  @override
  Future<List<StudentSubjectModel>> getSubjects({
    required int yearId,
    required int semesterId,
    required int departmentId,
  }) {
    return remoteDataSource.getSubjects(
      yearId: yearId,
      semesterId: semesterId,
      departmentId: departmentId,
    );
  }
}
