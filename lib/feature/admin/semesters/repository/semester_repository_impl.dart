import 'package:edusync_app/feature/admin/semesters/model/semester_model.dart';
import 'package:edusync_app/feature/admin/semesters/repository/semester_repository.dart';

class SemesterRepositoryImpl implements SemesterRepository {
  final List<SemesterModel> _allSemesters = [];

  @override
  List<SemesterModel> getSemesters() {
    return _allSemesters;
  }

  @override
  void addSemester(SemesterModel semester) {
    _allSemesters.add(semester);
  }

  @override
  void editSemester(int index, SemesterModel semester) {
    _allSemesters[index] = semester;
  }

  @override
  void deleteSemester(SemesterModel semester) {
    _allSemesters.remove(semester);
  }
}
