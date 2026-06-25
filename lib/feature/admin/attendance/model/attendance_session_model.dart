class AttendanceSessionModel {
  final String id;
  final DateTime sessionDate;
  final String subjectName;
  final int subjectId;
  final String instructorName;
  final String instructorId;

  AttendanceSessionModel({
    required this.id,
    required this.sessionDate,
    required this.subjectName,
    required this.subjectId,
    required this.instructorName,
    required this.instructorId,
  });

  factory AttendanceSessionModel.fromJson(Map<String, dynamic> json) {
    return AttendanceSessionModel(
      id: json['id'],
      sessionDate: DateTime.parse(json['sessionDate']),
      subjectName: json['subject']['engName'],
      subjectId: json['subject']['id'],
      instructorName: json['instructor']['fullName'],
      instructorId: json['instructor']['id'],
    );
  }
}
