import 'package:edusync_app/feature/students/model/student_subject_model.dart';

import 'student_instructor_model.dart';

class StudentInstructorSubjectModel {
  final int id;
  final int subjectId;
  final String instructorId;
  final StudentSubjectModel subject;
  final StudentInstructorModel instructor;

  const StudentInstructorSubjectModel({
    required this.id,
    required this.subjectId,
    required this.instructorId,
    required this.subject,
    required this.instructor,
  });

  factory StudentInstructorSubjectModel.fromJson(
      Map<String, dynamic> json) {
    return StudentInstructorSubjectModel(
      id: json['id'] ?? 0,
      subjectId: json['subjectId'] ?? 0,
      instructorId: json['instructorId'] ?? '',
      subject: StudentSubjectModel.fromJson(json['subject']),
      instructor: StudentInstructorModel.fromJson(json['instructor']),
    );
  }
}