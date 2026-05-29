import 'package:edusync_app/feature/admin/semesters/model/semester_model.dart';
import 'package:flutter/cupertino.dart';

import '../repository/semester_repository.dart';

class SemesterViewModel extends ChangeNotifier {
  final SemesterRepository _repository;
  SemesterViewModel(this._repository);
  String _searchQuery = '';
  List<SemesterModel> get semesters {
    final semesters = _repository.getSemesters();
    if (_searchQuery.isEmpty) {
      return semesters;
    }
    return semesters.where((semester) {
      return semester.arabicName.toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ) ||
          semester.englishName.toLowerCase().contains(
            _searchQuery.toLowerCase(),
          );
    }).toList();
  }

  bool get isEmpty => _repository.getSemesters().isEmpty;
  void addSemester(SemesterModel semester) {
    _repository.addSemester(semester);
    notifyListeners();
  }

  void editSemester(int index, SemesterModel semester) {
    _repository.editSemester(index, semester);
    notifyListeners();
  }

  void deleteSemester(SemesterModel semester) {
    _repository.deleteSemester(semester);
    notifyListeners();
  }

  void search(String value) {
    _searchQuery = value;
    notifyListeners();
  }
}
