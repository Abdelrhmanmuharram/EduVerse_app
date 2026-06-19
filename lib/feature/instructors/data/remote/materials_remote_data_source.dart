import '../../model/materials_model.dart';

abstract class MaterialsRemoteDataSource {
  Future<void> addMaterial(MaterialsModel material);
}