import '../model/materials_admin_model.dart';
import '../model/materials_request_model.dart';

abstract class MaterialsAdminRepository {
  Future<List<MaterialsAdminModel>> getMaterials();
  Future<bool> addMaterials(MaterialRequestModel material);
}