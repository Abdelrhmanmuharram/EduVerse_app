import 'package:edusync_app/feature/admin/instructors/repository/subject_repository.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/model/user_model.dart';
import '../../../users/repository/users_repository.dart';
import '../../student/model/subject_model.dart';
import '../model/instructor_subject_model.dart';
import '../model/instructor_subject_upsert_model.dart';
import '../model/update_instructor_model.dart';
import '../repository/instructor_repository.dart';
import '../repository/instructor_subject_repository.dart';

class InstructorViewModel extends ChangeNotifier {
  final UsersRepository usersRepository;
  final InstructorRepository instructorRepository;
  final InstructorSubjectRepository instructorSubjectRepository;
  final SubjectRepository subjectsRepository;

  InstructorViewModel(
    this.usersRepository,
    this.instructorRepository,
    this.instructorSubjectRepository,
    this.subjectsRepository,
  );

  bool isLoading = false;
  List<UserModel> _instructors = [];
  List<UserModel> get instructors => _instructors;
  List<UserModel> _filteredInstructors = [];
  bool _isSearching = false;

  List<UserModel> get filteredInstructors =>
      _isSearching ? _filteredInstructors : _instructors;
  bool get isEmpty => _instructors.isEmpty;
  List<InstructorSubjectModel> _subjects = [];
  List<InstructorSubjectModel> _originalSubjects = [];
  List<InstructorSubjectModel> get subjects => _subjects;
  List<SubjectModel> _allSubjects = [];
  List<SubjectModel> get allSubjects => _allSubjects;

  Future<void> loadInstructors() async {
    try {
      isLoading = true;
      notifyListeners();

      _instructors = await usersRepository.getUsersByRole('Instructor');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void searchInstructors(String query) {
    final searchText = query.trim().toLowerCase();

    if (searchText.isEmpty) {
      _isSearching = false;
      _filteredInstructors = [];
    } else {
      _isSearching = true;
      _filteredInstructors = _instructors.where((instructor) {
        return instructor.fullName.toLowerCase().contains(searchText);
      }).toList();
    }

    notifyListeners();
  }

  Future<String?> addInstructor({
    required String email,
    required String fullName,
    required String password,
    required int? departmentId,
  }) async {
    try {
      isLoading = true;
      notifyListeners();
      final instructorId = await instructorRepository.addInstructor(
        email: email,
        fullName: fullName,
        password: password,
        departmentId: departmentId,
      );
      await loadInstructors();
      return instructorId;
    } catch (e) {
      return null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadInstructorSubjects(String instructorId) async {
    try {
      isLoading = true;
      _subjects = [];
      _originalSubjects = [];
      notifyListeners();
      _subjects = await instructorSubjectRepository.getInstructorSubjects(
        instructorId,
      );
      _originalSubjects = List<InstructorSubjectModel>.from(_subjects);
      debugPrint('Subjects Count = ${_subjects.length}');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadAllSubjects() async {
    _allSubjects = await subjectsRepository.getSubjects();
    notifyListeners();
  }

  void updateSubjects(List<InstructorSubjectModel> subjects) {
    _subjects = subjects;
    notifyListeners();
  }

  Future<void> updateInstructor(UpdateInstructorModel instructor) async {
    try {
      isLoading = true;
      notifyListeners();
      await usersRepository.updateInstructor(instructor);
      await loadInstructors();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> bulkUpsertSubjects(String instructorId) async {
    final oldSubjectIds = _originalSubjects.map((e) => e.subjectId).toSet();

    final addedSubjects = _subjects
        .where((e) => !oldSubjectIds.contains(e.subjectId))
        .toList();
    if (addedSubjects.isEmpty) {
      return;
    }
    final subjectModels = addedSubjects.map((subject) {
      return InstructorSubjectUpsertModel(
        id: 0,
        instructorId: instructorId,
        subjectId: subject.subjectId,
      );
    }).toList();

    for (final item in subjectModels) {}
    await instructorSubjectRepository.bulkUpsertSubjects(subjectModels);
  }

  bool hasSubjectsChanged() {
    final originalIds = _originalSubjects.map((e) => e.subjectId).toSet();
    final currentIds = _subjects.map((e) => e.subjectId).toSet();
    if (originalIds.length != currentIds.length) {
      return true;
    }
    return !originalIds.containsAll(currentIds);
  }

  Future<void> deleteRemovedSubjects() async {
    final deletedSubjects = _originalSubjects
        .where(
          (original) => !_subjects.any((current) => current.id == original.id),
        )
        .toList();
    for (final subject in deletedSubjects) {
      await instructorSubjectRepository.deleteInstructorSubject(subject.id);
    }
  }

  void syncSubjectsSnapshot() {
    _originalSubjects = List<InstructorSubjectModel>.from(_subjects);
  }

  Future<bool> saveInstructor({
    required String instructorId,
    required String fullName,
    required String email,
    required int? departmentId,
  }) async {
    final instructor = UpdateInstructorModel(
      id: instructorId,
      fullName: fullName,
      email: email,
      departmentId: departmentId,
    );
    try {
      isLoading = true;
      notifyListeners();
      await usersRepository.updateInstructor(instructor);
      await deleteRemovedSubjects();
      await bulkUpsertSubjects(instructorId);
      syncSubjectsSnapshot();
      await loadInstructors();
      return true;
    } catch (e) {
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> toggleInstructorStatus(String userId, bool isActive) async {
    try {
      if (isActive) {
        await usersRepository.deactivateAccount(userId);
      } else {
        await usersRepository.reactivateAccount(userId);
      }
      final index = _instructors.indexWhere((e) => e.id == userId);
      if (index != -1) {
        _instructors[index] = _instructors[index].copyWith(isActive: !isActive);
      }
      final filteredIndex = _filteredInstructors.indexWhere(
        (e) => e.id == userId,
      );
      if (filteredIndex != -1) {
        _filteredInstructors[filteredIndex] =
            _filteredInstructors[filteredIndex].copyWith(isActive: !isActive);
      }
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteInstructor(String userId) async {
    try {
      await usersRepository.deleteUsers(userId);
      _instructors.removeWhere((instructor) => instructor.id == userId);
      _filteredInstructors.removeWhere((instructor) => instructor.id == userId);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
