import 'package:edusync_app/feature/instructors/model/instructor_material_model.dart';
import 'package:edusync_app/feature/instructors/model/materials_model.dart';
import 'package:edusync_app/feature/instructors/model/update_material_model.dart';

import '../../admin/attendance/model/attendance_session_request_model.dart';
import '../../admin/attendance/model/update_attendance_session_model.dart';
import '../data/remote/materials_remote_data_source.dart';
import '../model/instructor_attendance_session_model.dart';
import 'materials_repository.dart';

class MaterialsRepositoryImpl implements MaterialsRepository {
  final MaterialsRemoteDataSource _remoteDataSource;
  MaterialsRepositoryImpl(this._remoteDataSource);

  @override
  Future<void> addMaterial(MaterialsModel material) {
    return _remoteDataSource.addMaterial(material);
  }

  @override
  Future<List<InstructorMaterialModel>> getInstructorMaterials(
    String instructorId,
  ) {
    return _remoteDataSource.getInstructorMaterials(instructorId);
  }

  @override
  Future<void> deleteMaterial(int materialId) {
    return _remoteDataSource.deleteMaterial(materialId);
  }

  @override
  Future<void> updateMaterial(UpdateMaterialModel material) {
    return _remoteDataSource.updateMaterial(material);
  }

  @override
  Future<List<InstructorAttendanceSessionModel>>
  getInstructorAttendanceSessions(String instructorId) {
    return _remoteDataSource.getInstructorAttendanceSessions(instructorId);
  }

  @override
  Future<void> deleteAttendanceSession(String attendanceSessionId) {
    return _remoteDataSource.deleteAttendanceSession(attendanceSessionId);
  }

  @override
  Future<void> updateAttendanceSession(UpdateAttendanceSessionModel session) {
    return _remoteDataSource.updateAttendanceSession(session);
  }

  @override
  Future<void> addAttendanceSession(AttendanceSessionRequestModel session) {
    return _remoteDataSource.addAttendanceSession(session);
  }
}
