class AttendanceScanRequestModel {
  final DateTime attendanceTime;
  final bool isPresent;
  final String sessionId;
  final String studentId;

  AttendanceScanRequestModel({
    required this.attendanceTime,
    required this.isPresent,
    required this.sessionId,
    required this.studentId,
  });

  Map<String, dynamic> toJson() => {
    "attendanceTime": attendanceTime.toIso8601String(),
    "isPresent": isPresent,
    "sessionId": sessionId,
    "studentId": studentId,
  };
}
