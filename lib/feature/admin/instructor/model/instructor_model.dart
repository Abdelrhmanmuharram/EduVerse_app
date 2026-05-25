import 'package:edusync_app/feature/admin/student/model/subject_model.dart';

class InstructorsModel {
  final String email;
  final String password;
  final String fullName;
  final List<SubjectModel> subjects;
  bool isLocked;

  InstructorsModel({
    required this.email,
    required this.password,
    required this.fullName,
    required this.subjects,
    this.isLocked = true,
  });
}

