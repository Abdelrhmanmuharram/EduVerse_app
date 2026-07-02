import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/services/local_storage_service.dart';
import '../../admin/attendance/model/attendance_session_request_model.dart';
import '../../admin/attendance/model/update_attendance_session_model.dart';
import '../../admin/instructors/model/instructor_subject_model.dart';
import '../../admin/instructors/repository/instructor_subject_repository.dart';
import '../model/generate_ai_model.dart';
import '../model/instructor_attendance_session_model.dart';
import '../model/instructor_material_model.dart';
import '../model/single_session_attendance_model.dart';
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
  List<InstructorMaterialModel> materials = [];

  List<SingleSessionAttendanceModel> _attendances = [];
  List<SingleSessionAttendanceModel> get attendances => _attendances;

  List<SingleSessionAttendanceModel> _filteredAttendances = [];
  List<SingleSessionAttendanceModel> get filteredAttendances =>
      _filteredAttendances;

  InstructorSubjectModel? selectedSubject;
  final List<InstructorMaterialModel> _selectedMaterials = [];
  List<InstructorMaterialModel> get selectedMaterials => _selectedMaterials;

  Future<void> selectSubject(InstructorSubjectModel subject) async {
    selectedSubject = subject;

    final user = await LocalStorageService.getUser();
    if (user == null) return;
    final allMaterials = await _attendanceSessionRepository
        .getInstructorMaterials(user.id);
    materials = allMaterials
        .where((e) => e.subjectId == subject.subjectId)
        .toList();
    _selectedMaterials.clear();
    notifyListeners();
  }

  void toggleMaterial(InstructorMaterialModel material) {
    if (_selectedMaterials.any((e) => e.id == material.id)) {
      _selectedMaterials.removeWhere((e) => e.id == material.id);
    } else {
      _selectedMaterials.add(material);
    }
    notifyListeners();
  }

  bool isMaterialSelected(InstructorMaterialModel material) {
    return _selectedMaterials.any((e) => e.id == material.id);
  }

  Future<void> loadSessionAttendances(String sessionId) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();
      _attendances = await _attendanceSessionRepository.getSessionAttendances(
        sessionId,
      );
      _filteredAttendances = List.from(_attendances);
      notifyListeners();
    } on DioException catch (e) {
      _errorMessage = e.response?.data["message"] ?? e.message;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadAll() async {
    await Future.wait([
      loadAttendanceSessions(),
      loadSubjects(),
    ]);
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

  Future<List<int>> generateAI(GenerateAIModel model) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();
      return await _attendanceSessionRepository.generateAI(model);
    } on DioException catch (e) {
      _errorMessage =
          e.response?.data["message"] ?? e.message ?? "Failed to generate";
      throw Exception(_errorMessage);
    } catch (e) {
      _errorMessage = e.toString();
      throw Exception(_errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
