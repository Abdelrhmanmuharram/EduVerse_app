import 'package:edusync_app/feature/admin/student/model/subject_model.dart';

class InstructorsModel {
  final String id;
  final String email;
  final String fullName;
  final List<SubjectModel> subjects;
  final bool isLocked;
  final String password;

  InstructorsModel({
    required this.id,
    required this.email,
    required this.password,
    required this.fullName,
    required this.subjects,
    this.isLocked = true,
  });

  factory InstructorsModel.fromJson(Map<String, dynamic> json) {
    return InstructorsModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      password: '',
      fullName: json['fullName'] ?? '',
      subjects: [],
      isLocked: json['lockoutEnabled'] ?? false,
    );
  }
}

