import 'package:edusync_app/feature/admin/materials/model/materials_admin_model.dart';
import '../data/remote/materials_admin_remote_source.dart';
import 'materials_admin_repository.dart';

class MaterialsAdminRepositoryImpl implements MaterialsAdminRepository {
  final MaterialsAdminRemoteSource _remoteSource;
  MaterialsAdminRepositoryImpl(this._remoteSource);
  @override
  Future<List<MaterialsAdminModel>> getMaterials() {
    return _remoteSource.getMaterials();
  }
}
