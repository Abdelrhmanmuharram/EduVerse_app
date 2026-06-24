import 'package:edusync_app/feature/admin/materials/model/materials_admin_model.dart';
import 'package:edusync_app/feature/admin/materials/model/materials_request_model.dart';
import '../data/remote/materials_admin_remote_source.dart';
import '../model/update_materials_admin_model.dart';
import 'materials_admin_repository.dart';

class MaterialsAdminRepositoryImpl implements MaterialsAdminRepository {
  final MaterialsAdminRemoteSource _remoteSource;
  MaterialsAdminRepositoryImpl(this._remoteSource);
  @override
  Future<List<MaterialsAdminModel>> getMaterials() {
    return _remoteSource.getMaterials();
  }

  @override
  Future<bool> addMaterials(MaterialRequestModel material) {
    return _remoteSource.addMaterials(material);
  }

  @override
  Future<void> updateMaterials(UpdateMaterialsAdminModel material) {
    return _remoteSource.updateMaterials(material);
  }

  @override
  Future<void> deleteMaterials(int id) {
    return _remoteSource.deleteMaterials(id);
  }
}
