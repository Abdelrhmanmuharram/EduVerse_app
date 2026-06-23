import 'package:edusync_app/core/network/dio_client.dart';
import 'package:edusync_app/feature/admin/materials/model/materials_admin_model.dart';
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
}
