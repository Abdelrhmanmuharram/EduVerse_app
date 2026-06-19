import 'package:edusync_app/feature/instructors/model/materials_model.dart';

import '../data/remote/materials_remote_data_source.dart';
import 'materials_repository.dart';

class MaterialsRepositoryImpl implements MaterialsRepository {
  final MaterialsRemoteDataSource _remoteDataSource;
  MaterialsRepositoryImpl(this._remoteDataSource);

  @override
  Future<void> addMaterial(MaterialsModel material) {
    return _remoteDataSource.addMaterial(material);
  }
}
