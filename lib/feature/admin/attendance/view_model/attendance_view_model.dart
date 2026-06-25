import 'package:dio/dio.dart';
import 'package:edusync_app/feature/admin/attendance/model/attendance_session_model.dart';
import 'package:flutter/material.dart';
import '../../../../core/network/dio_error_handler.dart';
import '../model/attendance_session_request_model.dart';
import '../repository/attendance_repository.dart';
import 'package:intl/intl.dart';

class AttendanceViewModel extends ChangeNotifier {
  final AttendanceRepository _attendanceRepository;
  AttendanceViewModel(this._attendanceRepository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMages = '';
  String get errorMages => _errorMages;

  String? _deletingId;
  String? get deletingId => _deletingId;

  String? _selectedInstructorName;
  String? _selectedInstructorId;

  String? get selectedInstructorName => _selectedInstructorName;
  String? get selectedInstructorId => _selectedInstructorId;

  String? _selectedSubjectName;
  int? _selectedSubjectId;

  String? get selectedSubjectName => _selectedSubjectName;
  int? get selectedSubjectId => _selectedSubjectId;

  bool _isSearching = false;

  bool get isSearching => _isSearching;

  List<AttendanceSessionModel> _filteredAttendances = [];

  List<AttendanceSessionModel> get filteredAttendances =>
      _isSearching ? _filteredAttendances : _attendances;

  List<AttendanceSessionModel> _attendances = [];
  List<AttendanceSessionModel> get attendances => _attendances;

  void searchAttendance(String query) {
    final text = query.trim().toLowerCase();
    if (text.isEmpty) {
      _isSearching = false;
      _filteredAttendances = [];
    } else {
      _isSearching = true;

      _filteredAttendances = _attendances.where((attendance) {
        return attendance.subjectName.toLowerCase().contains(text) ||
            attendance.instructorName.toLowerCase().contains(text) ||
            DateFormat(
              'yyyy-MM-dd',
            ).format(attendance.sessionDate).toLowerCase().contains(text);
      }).toList();
    }

    notifyListeners();
  }

  Future<void> loadAttendances() async {
    try {
      _isLoading = true;
      notifyListeners();
      _attendances = await _attendanceRepository.getAttendance();
      _isLoading = false;
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> deleteAttendanceSession(String id) async {
    try {
      _errorMages = '';
      _deletingId = id;
      notifyListeners();
      await _attendanceRepository.deleteAttendanceSession(id);
      _attendances.removeWhere((attendance) => attendance.id == id);
      notifyListeners();
      return true;
    } catch (e) {
      if (e is DioException) {
        _errorMages = DioErrorHandler.handle(e).message;
      } else {
        _errorMages = 'Something went wrong';
      }
      return false;
    } finally {
      _deletingId = null;
      notifyListeners();
    }
  }

  Future<bool> createAttendanceSession({
    required String instructorId,
    required int subjectId,
    required DateTime sessionDate,
  }) async {
    try {
      _errorMages = '';
      _isLoading = true;
      notifyListeners();
      final session = AttendanceSessionRequestModel(
        instructorId: instructorId,
        subjectId: subjectId,
        sessionDate: DateTime.now(),
      );
      await _attendanceRepository.createAttendanceSession(session);
      await loadAttendances();
      return true;
    } catch (e) {
      if (e is DioException) {
        _errorMages = DioErrorHandler.handle(e).message;
      } else {
        _errorMages = 'Something went wrong';
      }

      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void selectInstructor({
    required String instructorName,
    required String instructorId,
  }) {
    _selectedInstructorName = instructorName;
    _selectedInstructorId = instructorId;
    notifyListeners();
  }

  void selectSubject({required String subjectName, required int subjectId}) {
    _selectedSubjectName = subjectName;
    _selectedSubjectId = subjectId;
    notifyListeners();
  }

  void clearSubject() {
    _selectedSubjectId = null;
    _selectedSubjectName = null;
    notifyListeners();
  }
}
