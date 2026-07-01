import 'package:edusync_app/feature/instructors/model/instructor_material_model.dart';
import 'package:edusync_app/feature/instructors/model/materials_model.dart';
import 'package:edusync_app/feature/instructors/model/update_material_model.dart';

import '../data/remote/materials_remote_data_source.dart';
import 'materials_repository.dart';

class MaterialsRepositoryImpl implements MaterialsRepository {
  final MaterialsRemoteDataSource _remoteDataSource;
  MaterialsRepositoryImpl(this._remoteDataSource);

  @override
  Future<void> addMaterial(MaterialsModel material) {
    return _remoteDataSource.addMaterial(material);
  }

  @override
  Future<List<InstructorMaterialModel>> getInstructorMaterials(String instructorId) {
    return _remoteDataSource.getInstructorMaterials(instructorId);
  }

  @override
  Future<void> deleteMaterial(int materialId) {
    return _remoteDataSource.deleteMaterial(materialId);
  }

  @override
  Future<void> updateMaterial(UpdateMaterialModel material) {
    return _remoteDataSource.updateMaterial(material);
  }
}
