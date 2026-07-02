import 'package:dio/dio.dart';
import 'package:edusync_app/core/constants/api_constants.dart';
import 'package:edusync_app/feature/admin/attendance/model/attendance_session_request_model.dart';
import 'package:edusync_app/feature/admin/attendance/model/update_attendance_session_model.dart';
import 'package:edusync_app/feature/instructors/model/instructor_attendance_session_model.dart';
import 'package:edusync_app/feature/instructors/model/instructor_material_model.dart';
import 'package:edusync_app/feature/instructors/model/materials_model.dart';
import 'package:edusync_app/feature/instructors/model/single_session_attendance_model.dart';
import 'package:edusync_app/feature/instructors/model/update_material_model.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/network/dio_client.dart';
import '../../model/generate_ai_model.dart';
import 'materials_remote_data_source.dart';

class MaterialsRemoteDataSourceImpl implements MaterialsRemoteDataSource {
  @override
  Future<void> addMaterial(MaterialsModel material) async {
    FormData formData = FormData.fromMap({
      'File': await MultipartFile.fromFile(material.file.path),
      'InstructorId': material.instructorId,
      'SubjectId': material.subjectId,
      'Title': material.title,
      'Description': material.description,
    });
    await DioClient.dio.post(APIConstants.getMaterials, data: formData);
  }

  @override
  Future<List<InstructorMaterialModel>> getInstructorMaterials(
    String instructorId,
  ) async {
    final response = await DioClient.dio.get(
      "${APIConstants.getInstructorMaterials}/$instructorId",
    );
    return (response.data["data"] as List)
        .map((e) => InstructorMaterialModel.fromJson(e))
        .toList();
  }

  @override
  Future<void> deleteMaterial(int materialId) async {
    await DioClient.dio.delete("${APIConstants.getMaterials}/$materialId");
  }

  @override
  Future<void> updateMaterial(UpdateMaterialModel material) async {
    await DioClient.dio.put(
      "${APIConstants.getMaterials}/${material.id}",
      data: material.toJson(),
    );
  }

  @override
  Future<List<InstructorAttendanceSessionModel>>
  getInstructorAttendanceSessions(String instructorId) async {
    final response = await DioClient.dio.get(
      "${APIConstants.getInstructorAttendanceSessions}/$instructorId",
    );
    return (response.data["data"] as List)
        .map((e) => InstructorAttendanceSessionModel.fromJson(e))
        .toList();
  }

  @override
  Future<void> deleteAttendanceSession(String attendanceSessionId) async {
    await DioClient.dio.delete(
      "${APIConstants.attendancesSessions}/$attendanceSessionId",
    );
  }

  @override
  Future<void> updateAttendanceSession(
    UpdateAttendanceSessionModel session,
  ) async {
    await DioClient.dio.put(
      "${APIConstants.attendancesSessions}/${session.id}",
      data: session.toJson(),
    );
  }

  @override
  Future<void> addAttendanceSession(
    AttendanceSessionRequestModel session,
  ) async {
    await DioClient.dio.post(
      APIConstants.attendancesSessions,
      data: session.toJson(),
    );
  }

  @override
  Future<List<SingleSessionAttendanceModel>> getSessionAttendances(
    String sessionId,
  ) async {
    final response = await DioClient.dio.get(
      "${APIConstants.getSessionAttendances}/$sessionId",
    );
    debugPrint(response.data.toString());
    debugPrint(response.data["data"].runtimeType.toString());
    debugPrint(response.data["data"][0].toString());
    return (response.data["data"] as List)
        .map((e) => SingleSessionAttendanceModel.fromJson(e))
        .toList();
  }

  @override
  Future<List<int>> generateAI(GenerateAIModel model) async {
    final response = await DioClient.dio.post(
      APIConstants.generateAi,
      data: model.toJson(),
      options: Options(
        responseType: ResponseType.bytes,
        receiveTimeout: const Duration(minutes: 2),
        sendTimeout: const Duration(minutes: 2),
      ),
    );
    return response.data;
  }
}
