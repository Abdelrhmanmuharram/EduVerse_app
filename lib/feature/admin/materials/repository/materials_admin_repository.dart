import '../model/materials_admin_model.dart';

abstract class MaterialsAdminRepository {
  Future<List<MaterialsAdminModel>> getMaterials();
}