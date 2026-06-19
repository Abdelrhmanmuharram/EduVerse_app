import '../model/materials_model.dart';

abstract class MaterialsRepository {
  Future<void> addMaterial(MaterialsModel material);
}