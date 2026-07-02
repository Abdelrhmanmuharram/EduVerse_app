import 'package:edusync_app/feature/admin/attendance/model/update_attendance_session_model.dart';

import '../../../admin/attendance/model/attendance_session_request_model.dart';
import '../../model/instructor_attendance_session_model.dart';
import '../../model/instructor_material_model.dart';
import '../../model/materials_model.dart';
import '../../model/update_material_model.dart';

abstract class MaterialsRemoteDataSource {
  Future<void> addMaterial(MaterialsModel material);
  Future<List<InstructorMaterialModel>> getInstructorMaterials(
    String instructorId,
  );
  Future<void> updateMaterial(UpdateMaterialModel material);
  Future<List<InstructorAttendanceSessionModel>>
  getInstructorAttendanceSessions(String instructorId);
  Future<void> deleteAttendanceSession(String attendanceSessionId);
  Future<void> updateAttendanceSession(UpdateAttendanceSessionModel session);
  Future<void> deleteMaterial(int materialId);
  Future<void> addAttendanceSession(AttendanceSessionRequestModel session);

}
