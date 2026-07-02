class InstructorAttendanceSessionModel {
  final String id;
  final String subjectName;
  final String subjectCode;
  final int subjectId;
  final DateTime sessionDate;
  final String instructorId;
  final String instructorName;

  const InstructorAttendanceSessionModel({
    required this.id,
    required this.subjectName,
    required this.subjectCode,
    required this.subjectId,
    required this.sessionDate,
    required this.instructorId,
    required this.instructorName,
  });

  factory InstructorAttendanceSessionModel.fromJson(Map<String, dynamic> json) {
    return InstructorAttendanceSessionModel(
      id: json["id"],
      subjectName: json["subject"]["engName"] ?? "",
      subjectCode: json["subject"]["code"] ?? "",
      subjectId: json["subjectId"],
      sessionDate: DateTime.parse(json["sessionDate"]),
      instructorId: json["instructorId"],
      instructorName: json["instructor"]["fullName"] ?? "",
    );
  }
}
