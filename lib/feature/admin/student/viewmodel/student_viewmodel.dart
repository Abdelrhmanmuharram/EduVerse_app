import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/model/user_model.dart';
import '../../../users/repository/users_repository.dart';
import '../../../years/model/year_model.dart';
import '../../departments/model/department_model.dart';
import '../model/add_student_model.dart';
import '../model/student_details_data_model.dart';
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
  StudentDetailsData? studentDetails;
  String? _originalFullName;
  int? _originalDepartmentId;
  int? _originalYearId;

  String? get originalFullName => _originalFullName;
  int? get originalDepartmentId => _originalDepartmentId;
  int? get originalYearId => _originalYearId;

  List<UserModel> get students {
    if (_searchQuery.trim().isEmpty) {
      return _students;
    }
    final query = _searchQuery.trim().toLowerCase();
    return _students.where((student) {
      return student.fullName.toLowerCase().contains(query) ||
          student.email.toLowerCase().contains(query) ||
          student.id.toLowerCase().contains(query);
    }).toList();
  }

  void search(String value) {
    _searchQuery = value;
    notifyListeners();
  }

  Future<void> loadStudents() async {
    _isLoading = true;
    notifyListeners();
    try {
      _students = await _repository.getUsersByRole('Student');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
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
      return years.firstWhere((y) => y.id == yearId).engName;
    } catch (_) {
      return '-';
    }
  }

  List<Student> getTableStudents(
    List<DepartmentModel> departments,
    List<YearModel> years,
  ) {
    return students.map((student) {
      return Student(
        id: student.id,
        code: '',
        name: student.fullName,
        dept: getDepartmentName(student.departmentId, departments),
        year: getYearName(student.yearId, years),
        isActive: student.isActive,
      );
    }).toList();
  }

  Future<void> addStudent(AddStudentModel student) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _repository.addStudent(student);
      await loadStudents();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateStudent(UpdateStudentModel student) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _repository.updateStudent(student);
      await loadStudents();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  bool hasChanges({
    required String currentName,
    required int? currentDepartmentId,
    required int? currentYearId,
  }) {
    return currentName.trim() != _originalFullName?.trim() ||
        currentDepartmentId != _originalDepartmentId ||
        currentYearId != _originalYearId;
  }

  void initializeStudent(UserModel user) {
    _originalFullName = user.fullName;
    _originalDepartmentId = user.departmentId;
    _originalYearId = user.yearId;
    studentDetails = StudentDetailsData(
      originalFullName: user.fullName,
      originalDepartmentId: user.departmentId,
      originalYearId: user.yearId,
      currentFullName: user.fullName,
      currentDepartmentId: user.departmentId,
      currentYearId: user.yearId,
    );
  }

  Future<void> deleteStudent(String userId) async {
    try {
      await _repository.deleteUsers(userId);
      _students.removeWhere((e) => e.id == userId);
      notifyListeners();
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ?? "Failed to delete student",
      );
    }
  }

  Future<void> deactivateStudent(String userId) async {
    try {
      await _repository.deactivateAccount(userId);
      final index = _students.indexWhere((e) => e.id == userId);
      if (index != -1) {
        _students[index] = _students[index].copyWith(
          isActive: false,
        );
      }
      notifyListeners();
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ?? "Failed to deactivate account",
      );
    }
  }

  Future<void> reactivateStudent(String userId) async {
    try {
      await _repository.reactivateAccount(userId);
      final index = _students.indexWhere((e) => e.id == userId);
      if (index != -1) {
        _students[index] = _students[index].copyWith(isActive: true);
      }
      notifyListeners();
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ?? "Failed to reactivate account",
      );
    }
  }
}
