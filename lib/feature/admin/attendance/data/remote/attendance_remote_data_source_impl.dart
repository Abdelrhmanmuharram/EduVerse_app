import 'package:edusync_app/feature/admin/attendance/data/remote/attendance_remote_data_source.dart';
import 'package:edusync_app/feature/admin/attendance/model/update_attendance_session_model.dart';
import '../../../../../core/constants/api_constants.dart';
import '../../../../../core/network/dio_client.dart';
import '../../model/attendance_session_model.dart';
import '../../model/attendance_session_request_model.dart';

class AttendanceRemoteDataSourceImpl implements AttendanceRemoteDataSource {
  @override
  Future<List<AttendanceSessionModel>> getAttendance() async {
    final response = await DioClient.dio.get(
      '${APIConstants.attendancesSessions}?skip=0&take=2147483647',
    );
    final data = response.data['data'] as List;
    return data.map((e) => AttendanceSessionModel.fromJson(e)).toList();
  }

  @override
  Future<void> deleteAttendanceSession(String id) async {
    await DioClient.dio.delete('${APIConstants.attendancesSessions}/$id');
  }

  @override
  Future<void> createAttendanceSession(
    AttendanceSessionRequestModel session,
  ) async {
    await DioClient.dio.post(
      APIConstants.attendancesSessions,
      data: session.toJson(),
    );
  }

  @override
  Future<void> updateAttendanceSession(
    UpdateAttendanceSessionModel session,
  ) async {
    await DioClient.dio.put(
      '${APIConstants.attendancesSessions}/${session.id}',
      data: session.toJson(),
    );
  }
}
