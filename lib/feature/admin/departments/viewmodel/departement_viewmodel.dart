import 'package:flutter/cupertino.dart';

import '../model/department_model.dart';
import '../repository/department_repository.dart';

class DepartmentViewModel extends ChangeNotifier {
  final DepartmentRepository _repository;
  DepartmentViewModel(this._repository);
  List<DepartmentModel> _departments = [];
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool get isEmpty => _departments.isEmpty;
  String _searchQuery = '';
  List<DepartmentModel> get departments {
    final departments = _departments;

    if (_searchQuery.isEmpty) {
      return departments;
    }
    return departments.where((department) {
      return department.arabicName.toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ) ||
          department.englishName.toLowerCase().contains(
            _searchQuery.toLowerCase(),
          );
    }).toList();
  }

  Future<void> loadDepartments() async {
    _isLoading = true;
    notifyListeners();
    _departments = await _repository.getDepartments();
    _isLoading = false;
    notifyListeners();
  }

  void search(String value) {
    _searchQuery = value;
    notifyListeners();
  }

  Future<void> addDepartment(DepartmentModel department) async {
    await _repository.addDepartment(department);
    await loadDepartments();
  }

  Future<void> updateDepartment(DepartmentModel department) async {
    await _repository.updateDepartment(department);
    await loadDepartments();
  }

  Future<void> deleteDepartment(DepartmentModel department) async {
    await _repository.deleteDepartment(department.id);
    await loadDepartments();
  }
}
