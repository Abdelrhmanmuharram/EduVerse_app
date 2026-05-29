import 'package:edusync_app/feature/admin/semesters/model/semester_model.dart';
import 'package:flutter/cupertino.dart';

import '../repository/semester_repository.dart';

class SemesterViewModel extends ChangeNotifier {
  final SemesterRepository _repository;
  SemesterViewModel(this._repository);
  List<SemesterModel> _semesters = [];
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String _searchQuery = '';
  List<SemesterModel> get semesters {
    final semesters = _semesters;
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

  Future<void> loadSemesters() async {
    _isLoading = true;
    notifyListeners();
    _semesters = await _repository.getSemesters();
    _isLoading = false;
    notifyListeners();
  }

  bool get isEmpty => _semesters.isEmpty;

  Future<void> addSemester(SemesterModel semester) async{
    await _repository.addSemester(semester);
    await loadSemesters();
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
