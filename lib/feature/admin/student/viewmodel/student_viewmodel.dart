import 'package:flutter/cupertino.dart';

import '../../../../core/model/user_model.dart';
import '../../../users/repository/users_repository.dart';
import '../../../years/model/year_model.dart';
import '../../departments/model/department_model.dart';
import '../model/student_model.dart';
import '../model/update_student_model.dart';

class StudentViewModel extends ChangeNotifier {
  final UsersRepository _repository;
  StudentViewModel(this._repository);

  List<UserModel> _students = [];
  bool get isEmpty => _students.isEmpty;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String _searchQuery = '';

  List<UserModel> get students {
    if (_searchQuery.isEmpty) {
      return _students;
    }

    return _students.where((student) {
      return student.fullName.toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ) ||
          student.email.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  void search(String value) {
    _searchQuery = value;
    notifyListeners();
  }

  Future<void> loadStudents() async {
    _isLoading = true;
    notifyListeners();
    _students = await _repository.getUsersByRole('Student');
    _isLoading = false;
    notifyListeners();
  }

  String getDepartmentName(
    int? departmentId,
    List<DepartmentModel> departments,
  ) {
    try {
      return departments.firstWhere((d) => d.id == departmentId).englishName;
    } catch (_) {
      return '-';
    }
  }

  String getYearName(int? yearId, List<YearModel> years) {
    try {
      return years.firstWhere((y) => y.id == yearId).englishName;
    } catch (_) {
      return '-';
    }
  }

  List<Student> getTableStudents(
    List<DepartmentModel> departments,
    List<YearModel> years,
  ) {
    return _students.map((student) {
      return Student(
        id: student.id,
        code: '',
        name: student.fullName,
        dept: getDepartmentName(student.departmentId, departments),
        year: getYearName(student.yearId, years),
      );
    }).toList();
  }

  Future<void> updateStudent(UpdateStudentModel student) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 5));
    try {
      await _repository.updateStudent(student);
      await loadStudents();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
