import 'package:flutter/material.dart';

import '../model/subjects_model.dart';
import '../repository/subject_repository.dart';

class SubjectsViewModel extends ChangeNotifier {
  final SubjectRepository _repository;
  SubjectsViewModel(this._repository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<SubjectsModel> _subjects = [];
  List<SubjectsModel> get subjects => _subjects;

  String _searchQuery = '';

  List<SubjectsModel> get filteredSubjects {
    if (_searchQuery.isEmpty) {
      return _subjects;
    }

    return _subjects.where((subject) {
      return subject.arbName.toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ) ||
          subject.engName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          subject.code.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  void searchSubjects(String value) {
    _searchQuery = value;
    notifyListeners();
  }

  Future<void> loadSubjects() async {
    try {
      _isLoading = true;
      notifyListeners();
      _subjects = await _repository.getSubjects();

    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
