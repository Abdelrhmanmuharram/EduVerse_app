import 'package:flutter/cupertino.dart';

import '../../../core/model/user_model.dart';
import '../../../core/services/local_storage_service.dart';
import '../materials/repository/student_material_repository.dart';
import '../model/student_dashboard_model.dart';
import '../model/student_instructor_subject_model.dart';
import '../repository/student_dashboard_repository.dart';
import '../repository/student_instructor_subject_repository.dart';

class StudentDashboardViewModel extends ChangeNotifier {
  final StudentMaterialRepository _materialRepository;
  final StudentDashboardRepository _dashboardrepository;
  StudentDashboardViewModel(
    this._dashboardrepository,
    this._materialRepository,
  );

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage = '';
  String? get errorMessage => _errorMessage;

  final Map<int, int> _materialsCount = {};
  Map<int, int> get materialsCount => _materialsCount;

  final Map<int, String> _instructors = {};
  Map<int, String> get instructors => _instructors;

  UserModel? _user;
  UserModel? get user => _user;

  StudentDashboardModel? _dashboard;
  StudentDashboardModel? get dashboard => _dashboard;

  Future<void> getDashboard() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      _user = await LocalStorageService.getUser();
      _dashboard = await _dashboardrepository.getDashboard();
      _materialsCount.clear();
      _instructors.clear();
      await Future.wait(
        _dashboard!.subjectAttendances.map((subject) async {
          final materials = await _materialRepository.getSubjectMaterials(
            subject.subjectId,
          );
          _materialsCount[subject.subjectId] = materials.length;
          print(
            'Subject ${subject.subjectId}: ${materials.length}',
          );
          if (materials.isNotEmpty) {
            _instructors[subject.subjectId] = materials.first.instructorName;
          }
        }),
      );
    } catch (e) {
      _errorMessage = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }
}
