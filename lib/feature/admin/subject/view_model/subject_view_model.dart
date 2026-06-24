import 'package:flutter/material.dart';
import '../model/subjects_model.dart';
import '../repository/subjects_repository.dart';

class SubjectsViewModel extends ChangeNotifier {
  final SubjectsRepository _repository;
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

  Future<void> deleteSubject(int id) async {
    try {
      _isLoading = true;
      notifyListeners();
      await _repository.deleteSubject(id);
      await loadSubjects();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateSubject(int id, SubjectsModel subject) async {
    try {
      _isLoading = true;
      notifyListeners();
      await _repository.updateSubject(id, subject);
      await loadSubjects();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addSubject(SubjectsModel subject) async {
    try {
      _isLoading = true;
      notifyListeners();
      await _repository.addSubject(subject);
      await loadSubjects();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String> getNextCode() async {
    return await _repository.getNextCode();
  }
}
