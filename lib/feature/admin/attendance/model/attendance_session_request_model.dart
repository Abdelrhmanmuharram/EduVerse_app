class AttendanceSessionRequestModel {
  final String instructorId;
  final int subjectId;
  final DateTime sessionDate;

  AttendanceSessionRequestModel({
    required this.instructorId,
    required this.subjectId,
    required this.sessionDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'instructorId': instructorId,
      'subjectId': subjectId,
      'sessionDate': sessionDate.toIso8601String(),
    };
  }
}
