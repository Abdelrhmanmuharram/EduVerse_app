import '../../student/model/subject_model.dart';

class InstructorSubjectModel {
  final int id;
  final String instructorId;
  final int subjectId;
  final SubjectModel subject;

  InstructorSubjectModel({
    required this.id,
    required this.instructorId,
    required this.subjectId,
    required this.subject,
  });

  factory InstructorSubjectModel.fromJson(Map<String, dynamic> json,) {
    return InstructorSubjectModel(
      id: json['id'],
      instructorId: json['instructorId'],
      subjectId: json['subjectId'],
      subject: SubjectModel.fromJson(json['subject']),
    );
  }
}
