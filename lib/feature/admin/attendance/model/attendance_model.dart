class AttendanceModel {
  final int id;
  final String studentId;
  final String studentName;
  final String sessionId;
  final DateTime attendanceTime;
  final bool isPresent;
  final String subjectName;
  final String instructorName;

  AttendanceModel({
    required this.id,
    required this.studentId,
    required this.studentName,
    required this.sessionId,
    required this.attendanceTime,
    required this.isPresent,
    required this.subjectName,
    required this.instructorName,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      id: json['id'],
      studentId: json['studentId'],
      studentName: json['student']['fullName'],
      sessionId: json['sessionId'],
      attendanceTime: DateTime.parse(json['attendanceTime']),
      isPresent: json['isPresent'],
      subjectName: json['attendanceSession']['subject']['engName'],
      instructorName: json['attendanceSession']['instructor']['fullName'],
    );
  }
}
