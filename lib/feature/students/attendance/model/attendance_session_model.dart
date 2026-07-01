import '../../materials/model/student_subject_model.dart';

class AttendanceSessionModel {
  final String id;
  final DateTime sessionDate;
  final int subjectId;
  final String instructorId;
  final StudentSubjectModel? subject;

  AttendanceSessionModel({
    required this.id,
    required this.sessionDate,
    required this.subjectId,
    required this.instructorId,
    this.subject,
  });

  factory AttendanceSessionModel.fromJson(Map<String, dynamic> json) {
    return AttendanceSessionModel(
      id: json['id'],
      sessionDate: DateTime.parse(json['sessionDate']),
      subjectId: json['subjectId'],
      instructorId: json['instructorId'],
      subject: json['subject'] != null
          ? StudentSubjectModel.fromJson(json['subject'])
          : null,
    );
  }
}