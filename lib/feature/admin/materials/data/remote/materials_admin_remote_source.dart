import '../../model/materials_admin_model.dart';

abstract class MaterialsAdminRemoteSource {
  Future<List<MaterialsAdminModel>> getMaterials();
}