import 'package:dio/dio.dart';
import 'package:edusync_app/core/network/dio_client.dart';
import 'package:edusync_app/feature/admin/materials/model/materials_admin_model.dart';
import 'package:edusync_app/feature/admin/materials/model/materials_request_model.dart';
import 'package:edusync_app/feature/admin/materials/model/update_materials_admin_model.dart';
import '../../../../../core/constants/api_constants.dart';
import 'materials_admin_remote_source.dart';

class MaterialsAdminRemoteSourceImpl implements MaterialsAdminRemoteSource {
  @override
  Future<List<MaterialsAdminModel>> getMaterials() async {
    final response = await DioClient.dio.get(APIConstants.getMaterials);
    return (response.data['data'] as List)
        .map((e) => MaterialsAdminModel.fromJson(e))
        .toList();
  }

  @override
  Future<bool> addMaterials(MaterialRequestModel material) async {
    final formData = FormData.fromMap({
      'File': await MultipartFile.fromFile(material.file.path),
      'InstructorId': material.instructorId,
      'SubjectId': material.subjectId,
      'Title': material.title,
      'Description': material.description,
    });

    final response = await DioClient.dio.post(
      APIConstants.getMaterials,
      data: formData,
    );
    return response.statusCode == 200 || response.statusCode == 201;
  }

  @override
  Future<void> deleteMaterials(int id) async {
    await DioClient.dio.delete('${APIConstants.getMaterials}/$id');
  }

  @override
  Future<void> updateMaterials(UpdateMaterialsAdminModel material) async {
    await DioClient.dio.put(
      '${APIConstants.getMaterials}/${material.id}',
      data: material.toJson(),
    );
  }
}
