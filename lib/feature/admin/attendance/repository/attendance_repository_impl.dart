import 'package:edusync_app/feature/admin/attendance/model/attendance_session_model.dart';
import 'package:edusync_app/feature/admin/attendance/model/update_attendance_session_model.dart';
import 'package:edusync_app/feature/students/attendance/model/attendance_scan_request_model.dart';
import 'package:edusync_app/feature/students/attendance/model/student_attendance_model.dart';
import '../data/remote/attendance_remote_data_source.dart';
import '../model/attendance_session_request_model.dart';
import 'attendance_repository.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  final AttendanceRemoteDataSource _remoteDataSource;
  AttendanceRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<AttendanceSessionModel>> getAttendance() {
    return _remoteDataSource.getAttendance();
  }

  @override
  Future<void> deleteAttendanceSession(String id) {
    return _remoteDataSource.deleteAttendanceSession(id);
  }

  @override
  Future<void> createAttendanceSession(AttendanceSessionRequestModel session) {
    return _remoteDataSource.createAttendanceSession(session);
  }

  @override
  Future<void> updateAttendanceSession(UpdateAttendanceSessionModel session) {
    return _remoteDataSource.updateAttendanceSession(session);
  }

  @override
  Future<void> addAttendance(AttendanceScanRequestModel attendance) async {
    await _remoteDataSource.addAttendance(attendance);
  }

  @override
  Future<List<StudentAttendanceModel>> getAttendances() {
    return _remoteDataSource.getAttendances();
  }
}
