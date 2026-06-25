import 'package:edusync_app/feature/admin/attendance/model/attendance_session_model.dart';
import 'package:edusync_app/feature/admin/attendance/model/attendance_session_request_model.dart';
abstract class AttendanceRemoteDataSource {
  Future<List<AttendanceSessionModel>> getAttendance();
  Future<void> createAttendanceSession(AttendanceSessionRequestModel session);
  Future<void> deleteAttendanceSession(String id);
}