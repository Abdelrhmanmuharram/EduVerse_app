import '../../model/materials_admin_model.dart';
import '../../model/materials_request_model.dart';
import '../../model/update_materials_admin_model.dart';

abstract class MaterialsAdminRemoteSource {
  Future<List<MaterialsAdminModel>> getMaterials();
  Future<bool> addMaterials(MaterialRequestModel material);
  Future<void> updateMaterials(UpdateMaterialsAdminModel material);
  Future<void> deleteMaterials(int id);
}