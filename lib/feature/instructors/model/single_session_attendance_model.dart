class SingleSessionAttendanceModel {
  final int id;
  final String studentId;
  final String studentName;
  final String studentEmail;
  final DateTime attendanceTime;
  final bool isPresent;
  final String sessionId;

  const SingleSessionAttendanceModel({
    required this.id,
    required this.studentId,
    required this.studentName,
    required this.studentEmail,
    required this.attendanceTime,
    required this.isPresent,
    required this.sessionId,
  });

  factory SingleSessionAttendanceModel.fromJson(Map<String, dynamic> json) {
    return SingleSessionAttendanceModel(
      id: json["id"],
      studentId: json["studentId"],
      studentName: json["student"]["fullName"],
      studentEmail: json["student"]["email"],
      attendanceTime: DateTime.parse(json["attendanceTime"]),
      isPresent: json["isPresent"],
      sessionId: json["sessionId"],
    );
  }
}