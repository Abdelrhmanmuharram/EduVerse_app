import 'package:flutter/material.dart';

import '../model/department_model.dart';
import '../repository/department_repository.dart';

class DepartmentViewModel extends ChangeNotifier {
  final DepartmentRepository _repository;
  DepartmentViewModel(this._repository);
  String _searchQuery = '';
  List<DepartmentModel> get departments {
    final departments = _repository.getDepartments();
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

  bool get isEmpty => _repository.getDepartments().isEmpty;
  void addDepartment(DepartmentModel department) {
    _repository.addDepartment(department);
    notifyListeners();
  }

  void deleteDepartment(DepartmentModel department) {
    _repository.deleteDepartment(department);
    notifyListeners();
  }

  void editDepartment(int index, DepartmentModel department) {
    _repository.editDepartment(index, department);
    notifyListeners();
  }

  void search(String value) {
    _searchQuery = value;
    notifyListeners();
  }
}
