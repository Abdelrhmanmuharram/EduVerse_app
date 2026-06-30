import 'package:flutter/cupertino.dart';
import '../../../core/model/user_model.dart';
import '../../../core/services/local_storage_service.dart';
import '../materials/model/student_subject_model.dart';
import '../materials/repository/student_material_repository.dart';
import '../materials/repository/student_subject_repository.dart';
import '../model/student_dashboard_model.dart';
import '../model/subject_attendance_model.dart';
import '../repository/student_dashboard_repository.dart';
import '../semester/model/system_setting_model.dart';
import '../semester/repository/system_setting_repository.dart';
import '../subjects/repository/student_subject_instructor_repository.dart';

class StudentDashboardViewModel extends ChangeNotifier {
  final StudentMaterialRepository _materialRepository;
  final StudentDashboardRepository _dashboardRepository;
  final StudentSubjectRepository _subjectRepository;
  final SystemSettingRepository _systemSettingRepository;
  final StudentSubjectInstructorRepository _instructorRepository;
  StudentDashboardViewModel(
    this._dashboardRepository,
    this._materialRepository,
    this._subjectRepository,
    this._systemSettingRepository,
    this._instructorRepository,
  );

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage = '';
  String? get errorMessage => _errorMessage;

  final Map<int, int> _materialsCount = {};
  Map<int, int> get materialsCount => _materialsCount;

  final Map<int, List<String>> _instructors = {};
  Map<int, List<String>> get instructors => _instructors;

  List<StudentSubjectModel> _subjects = [];
  List<StudentSubjectModel> get subjects => _subjects;

  SystemSettingModel? _systemSetting;
  SystemSettingModel? get systemSetting => _systemSetting;

  final Map<int, SubjectAttendanceModel> _attendanceMap = {};
  Map<int, SubjectAttendanceModel> get attendanceMap => _attendanceMap;

  UserModel? _user;
  UserModel? get user => _user;

  StudentDashboardModel? _dashboard;
  StudentDashboardModel? get dashboard => _dashboard;

  List<StudentSubjectModel> _filteredSubjects = [];
  List<StudentSubjectModel> get filteredSubjects => _filteredSubjects;

  Future<void> _loadUser() async {
    _user = await LocalStorageService.getUser();
    if (_user == null) {
      throw Exception('User not found');
    }
  }

  Future<void> _loadSubjects() async {
    final settings = await _systemSettingRepository.getSystemSetting();
    _subjects = await _subjectRepository.getSubjects(
      departmentId: _user!.departmentId!,
      semesterId: settings.currentSemester.id,
      yearId: _user!.yearId!,
    );
    _filteredSubjects = List.from(_subjects);
  }

  void searchSubjects(String query) {
    if (query.trim().isEmpty) {
      _filteredSubjects = List.from(_subjects);
    } else {
      final q = query.toLowerCase();

      _filteredSubjects = _subjects.where((subject) {
        return subject.subjectName.toLowerCase().contains(q) ||
            subject.subjectName.toLowerCase().contains(q) ||
            subject.code.toLowerCase().contains(q);
      }).toList();
    }
    notifyListeners();
  }

  Future<void> _loadDashboard() async {
    _dashboard = await _dashboardRepository.getDashboard();
    _attendanceMap
      ..clear()
      ..addAll({
        for (final attendance in _dashboard!.subjectAttendances)
          attendance.subjectId: attendance,
      });
  }

  Future<void> _loadMaterials() async {
    _materialsCount.clear();
    _instructors.clear();
    await Future.wait(
      _subjects.map((subject) async {
        final materials = await _materialRepository.getSubjectMaterials(
          subject.id,
        );
        _materialsCount[subject.id] = materials.length;
        final instructors = await _instructorRepository.getSubjectInstructors(
          subject.id,
        );
        _instructors[subject.id] = instructors.map((e) => e.fullName).toList();
      }),
    );
  }

  Future<void> loadData() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      await _loadUser();
      await _loadSubjects();
      await _loadDashboard();
      await _loadMaterials();
    } catch (e) {
      _errorMessage = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }

  SubjectAttendanceModel? getAttendanceBySubjectId(int subjectId) {
    return _attendanceMap[subjectId];
  }
}
