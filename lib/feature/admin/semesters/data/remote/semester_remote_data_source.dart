import '../../model/semester_model.dart';

abstract class SemesterRemoteDataSource {
  Future<List<SemesterModel>> getSemesters();
  Future<void> addSemester(SemesterModel semester);
  Future<void> deleteSemester(int id);
}