import 'package:edusync_app/feature/admin/attendance/model/attendance_session_model.dart';
import 'package:edusync_app/feature/students/model/attendance_scan_request_model.dart';

import '../model/attendance_session_request_model.dart';
import '../model/update_attendance_session_model.dart';

abstract class AttendanceRepository {
  Future<List<AttendanceSessionModel>> getAttendance();
  Future<void> createAttendanceSession(AttendanceSessionRequestModel session);
  Future<void> updateAttendanceSession(UpdateAttendanceSessionModel session);
  Future<void> addAttendance(AttendanceScanRequestModel attendance);
  Future<void> deleteAttendanceSession(String id);
}
