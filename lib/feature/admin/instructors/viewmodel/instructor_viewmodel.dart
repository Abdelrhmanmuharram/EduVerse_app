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
      debugPrint("NEW INSTRUCTOR ID = $instructorId");
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
    _subjects = await instructorSubjectRepository.getInstructorSubjects(
      instructorId,
    );
    _originalSubjects = List<InstructorSubjectModel>.from(_subjects);
    debugPrint('Subjects Count = ${_subjects.length}');
    notifyListeners();
  }

  Future<void> loadAllSubjects() async {
    _allSubjects = await subjectsRepository.getSubjects();
    debugPrint('All Subjects Count = ${_allSubjects.length}');
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
    debugPrint('Added Subjects Count = ${addedSubjects.length}');
    if (addedSubjects.isEmpty) {
      debugPrint('No new subjects to add');
      return;
    }
    final subjectModels = addedSubjects.map((subject) {
      return InstructorSubjectUpsertModel(
        id: 0,
        instructorId: instructorId,
        subjectId: subject.subjectId,
      );
    }).toList();

    for (final item in subjectModels) {
      debugPrint('Instructor=${item.instructorId} Subject=${item.subjectId}');
    }
    await instructorSubjectRepository.bulkUpsertSubjects(subjectModels);
  }
}