import 'attendance_session_model.dart';

class StudentAttendanceModel {
  final int id;
  final String studentId;
  final String sessionId;
  final bool isPresent;
  final DateTime attendanceTime;
  final AttendanceSessionModel attendanceSession;

  StudentAttendanceModel({
    required this.id,
    required this.studentId,
    required this.sessionId,
    required this.isPresent,
    required this.attendanceTime,
    required this.attendanceSession,
  });

  factory StudentAttendanceModel.fromJson(Map<String, dynamic> json) {
    return StudentAttendanceModel(
      id: json['id'],
      studentId: json['studentId'],
      sessionId: json['sessionId'],
      isPresent: json['isPresent'],
      attendanceTime: DateTime.parse(json['attendanceTime']),
      attendanceSession: AttendanceSessionModel.fromJson(
        json['attendanceSession'],
      ),
    );
  }
}