class UpdateAttendanceSessionModel {
  final String id;
  final String instructorId;
  final DateTime sessionDate;
  final int subjectId;

  const UpdateAttendanceSessionModel({
    required this.id,
    required this.instructorId,
    required this.sessionDate,
    required this.subjectId,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "instructorId": instructorId,
      "sessionDate": sessionDate.toIso8601String(),
      "subjectId": subjectId,
    };
  }
}
