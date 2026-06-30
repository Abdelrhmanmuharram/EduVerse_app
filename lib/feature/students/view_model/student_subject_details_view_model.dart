import 'package:flutter/material.dart';
import '../../../core/model/user_model.dart';
import '../../../core/services/local_storage_service.dart';
import '../../admin/attendance/repository/attendance_repository.dart';
import '../attendance/model/attendance_scan_request_model.dart';
import '../materials/model/student_material_model.dart';
import '../materials/repository/student_material_repository.dart';
import '../subjects/model/student_subject_instructor_model.dart';
import '../subjects/repository/student_subject_instructor_repository.dart';

class StudentSubjectDetailsViewModel extends ChangeNotifier {
  final StudentMaterialRepository _materialRepository;
  final StudentSubjectInstructorRepository _instructorRepository;
  final AttendanceRepository _attendanceRepository;

  StudentSubjectDetailsViewModel(
      this._materialRepository,
      this._instructorRepository,
      this._attendanceRepository,
      );

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  UserModel? _user;

  List<StudentMaterialModel> _materials = [];
  List<StudentMaterialModel> get materials => _materials;

  List<StudentSubjectInstructorModel> _instructors = [];
  List<StudentSubjectInstructorModel> get instructors => _instructors;

  Future<void> loadData(int subjectId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _user = await LocalStorageService.getUser();

      final results = await Future.wait([
        _materialRepository.getSubjectMaterials(subjectId),
        _instructorRepository.getSubjectInstructors(subjectId),
      ]);

      _materials = results[0] as List<StudentMaterialModel>;
      _instructors = results[1] as List<StudentSubjectInstructorModel>;
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> scanAttendance({
    required String qrData,
  }) async {
    try {
      _errorMessage = null;

      await _attendanceRepository.addAttendance(
        AttendanceScanRequestModel(
          attendanceTime: DateTime.now(),
          isPresent: true,
          sessionId: qrData,
          studentId: _user!.id,
        ),
      );

      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }
}