import 'package:edusync_app/feature/admin/semesters/model/semester_model.dart';

abstract class SemesterRepository {
  Future<List<SemesterModel>> getSemesters();
  Future<void> addSemester(SemesterModel semester);
  void deleteSemester(SemesterModel semester);
  void editSemester(int index, SemesterModel semester);
}
