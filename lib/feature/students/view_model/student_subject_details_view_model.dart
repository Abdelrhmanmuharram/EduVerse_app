import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../core/model/user_model.dart';
import '../../../core/services/local_storage_service.dart';
import '../../admin/attendance/repository/attendance_repository.dart';
import '../attendance/model/attendance_scan_request_model.dart';
import '../attendance/model/student_attendance_model.dart';
import '../materials/model/student_material_model.dart';
import '../materials/repository/student_material_repository.dart';
import '../semester/model/system_setting_model.dart';
import '../semester/repository/system_setting_repository.dart';
import '../subjects/model/student_subject_instructor_model.dart';
import '../subjects/repository/student_subject_instructor_repository.dart';

class StudentSubjectDetailsViewModel extends ChangeNotifier {
  final StudentMaterialRepository _materialRepository;
  final StudentSubjectInstructorRepository _instructorRepository;
  final AttendanceRepository _attendanceRepository;
  final SystemSettingRepository _systemSettingRepository;

  StudentSubjectDetailsViewModel(
    this._materialRepository,
    this._instructorRepository,
    this._attendanceRepository,
    this._systemSettingRepository,
  );

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  UserModel? _user;

  List<StudentMaterialModel> _materials = [];
  List<StudentMaterialModel> get materials => _materials;

  int _totalSessions = 0;
  int get totalSessions => _totalSessions;

  SystemSettingModel? _systemSetting;
  SystemSettingModel? get systemSetting => _systemSetting;

  int _attendedSessions = 0;
  int get attendedSessions => _attendedSessions;

  List<StudentAttendanceModel> _attendanceHistory = [];
  List<StudentAttendanceModel> get attendanceHistory => _attendanceHistory;

  List<StudentSubjectInstructorModel> _instructors = [];
  List<StudentSubjectInstructorModel> get instructors => _instructors;

  int? _subjectId;

  Future<void> loadData(int subjectId) async {
    _subjectId = subjectId;
    _isLoading = true;
    notifyListeners();
    try {
      _user = await LocalStorageService.getUser();
      _systemSetting = await _systemSettingRepository.getSystemSetting();
      final results = await Future.wait([
        _materialRepository.getSubjectMaterials(subjectId),
        _instructorRepository.getSubjectInstructors(subjectId),
        _attendanceRepository.getAttendances(),
      ]);
      _materials = results[0] as List<StudentMaterialModel>;
      _instructors = results[1] as List<StudentSubjectInstructorModel>;
      final attendances = results[2] as List<StudentAttendanceModel>;
      debugPrint('Attendances Count: ${attendances.length}');
      _attendanceHistory = attendances.where((attendance) {
        return attendance.studentId == _user!.id &&
            attendance.attendanceSession.subjectId == subjectId;
      }).toList();
      debugPrint(
        'Filtered Count: ${_attendanceHistory.length}',
      );
      _attendedSessions = _attendanceHistory.where((e) => e.isPresent).length;
      _totalSessions = _attendanceHistory
          .map((e) => e.attendanceSession.id)
          .toSet()
          .length;
    } catch (e) {
      _errorMessage = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<bool> scanAttendance({required String qrData}) async {
    try {
      _errorMessage = null;
      final sessionId = qrData.split('|').first;
      final request = AttendanceScanRequestModel(
        attendanceTime: DateTime.now(),
        isPresent: true,
        sessionId: sessionId,
        studentId: _user!.id,
      );

      debugPrint(request.toJson().toString());

      await _attendanceRepository.addAttendance(request);

      return true;
    } on DioException catch (e) {
      _errorMessage = e.response?.data.toString();
      return false;
    }
  }

  Future<void> refresh() async {
    debugPrint("Refresh called");
    if (_subjectId == null) return;
    await loadData(_subjectId!);
  }
}
