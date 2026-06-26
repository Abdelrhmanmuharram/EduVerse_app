class UpdateAttendanceSessionModel {
  final String id;
  final String instructorId;
  final int subjectId;
  final DateTime sessionDate;

  UpdateAttendanceSessionModel({
    required this.id,
    required this.instructorId,
    required this.subjectId,
    required this.sessionDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'instructorId': instructorId,
      'subjectId': subjectId,
      'sessionDate': sessionDate.toIso8601String(),
    };
  }
}
