import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/services/local_storage_service.dart';
import '../../admin/attendance/model/attendance_session_request_model.dart';
import '../../admin/attendance/model/update_attendance_session_model.dart';
import '../../admin/instructors/model/instructor_subject_model.dart';
import '../../admin/instructors/repository/instructor_subject_repository.dart';
import '../model/instructor_attendance_session_model.dart';
import '../repository/materials_repository.dart';

class AttendanceSessionViewModel extends ChangeNotifier {
  final MaterialsRepository _attendanceSessionRepository;
  final InstructorSubjectRepository _instructorSubjectRepository;

  AttendanceSessionViewModel(
    this._attendanceSessionRepository,
    this._instructorSubjectRepository,
  );

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _sortAscending = true;
  bool get sortAscending => _sortAscending;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<InstructorAttendanceSessionModel> _sessions = [];
  List<InstructorAttendanceSessionModel> get sessions => _filteredSessions;

  List<InstructorAttendanceSessionModel> _filteredSessions = [];

  List<InstructorSubjectModel> subjects = [];

  Future<void> loadAll() async {
    await Future.wait([loadAttendanceSessions(), loadSubjects()]);
  }

  Future<void> loadSubjects() async {
    try {
      final user = await LocalStorageService.getUser();

      if (user == null) {
        throw Exception("User not found");
      }

      subjects = await _instructorSubjectRepository.getInstructorSubjects(
        user.id,
      );

      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> loadAttendanceSessions() async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final user = await LocalStorageService.getUser();

      if (user == null) {
        throw Exception("User not found");
      }

      _sessions = await _attendanceSessionRepository
          .getInstructorAttendanceSessions(user.id);

      _filteredSessions = List.from(_sessions);
    } on DioException catch (e) {
      _errorMessage = e.response?.data["message"] ?? e.message;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void search(String value) {
    if (value.trim().isEmpty) {
      _filteredSessions = List.from(_sessions);
    } else {
      final query = value.toLowerCase();

      _filteredSessions = _sessions.where((session) {
        return session.subjectName.toLowerCase().contains(query) ||
            session.subjectCode.toLowerCase().contains(query);
      }).toList();
    }

    notifyListeners();
  }

  void sortBySubject() {
    _sortAscending = !_sortAscending;

    _filteredSessions.sort((a, b) {
      return _sortAscending
          ? a.subjectName.compareTo(b.subjectName)
          : b.subjectName.compareTo(a.subjectName);
    });

    notifyListeners();
  }

  Future<void> deleteAttendanceSession(String id) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _attendanceSessionRepository.deleteAttendanceSession(id);

      _sessions.removeWhere((e) => e.id == id);
      _filteredSessions.removeWhere((e) => e.id == id);
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ?? "Failed to delete attendance session",
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateAttendanceSession(
    UpdateAttendanceSessionModel session,
  ) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _attendanceSessionRepository.updateAttendanceSession(session);

      final index = _sessions.indexWhere((e) => e.id == session.id);

      if (index != -1) {
        _sessions[index] = InstructorAttendanceSessionModel(
          id: session.id,
          instructorId: session.instructorId,
          subjectId: session.subjectId,
          sessionDate: session.sessionDate,
          instructorName: _sessions[index].instructorName,
          subjectName: _sessions[index].subjectName,
          subjectCode: _sessions[index].subjectCode,
        );

        _filteredSessions = List.from(_sessions);
      }
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ?? "Failed to update attendance session",
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addAttendanceSession(
    AttendanceSessionRequestModel session,
  ) async {
    try {
      _isLoading = true;
      notifyListeners();
      await _attendanceSessionRepository.addAttendanceSession(session);
      await loadAttendanceSessions();
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ?? "Failed to add attendance session",
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
