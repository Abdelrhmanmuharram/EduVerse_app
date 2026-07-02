class AttendanceSessionRequestModel {
  final String instructorId;
  final DateTime sessionDate;
  final int subjectId;

  const AttendanceSessionRequestModel({
    required this.instructorId,
    required this.sessionDate,
    required this.subjectId,
  });

  Map<String, dynamic> toJson() {
    return {
      "instructorId": instructorId,
      "sessionDate": sessionDate.toIso8601String(),
      "subjectId": subjectId,
    };
  }
}