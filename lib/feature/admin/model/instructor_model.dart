import 'package:edusync_app/feature/admin/model/subject_model.dart';

class InstructorsModel {
  final String id;
  final String firstName;
  final String lastName;
  final String username;
  final String academicRole;
  final List<SubjectModel> subjects;

  InstructorsModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.academicRole,
    required this.subjects,
  });
}

