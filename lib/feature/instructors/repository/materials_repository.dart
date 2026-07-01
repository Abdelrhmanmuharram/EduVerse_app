import '../model/instructor_material_model.dart';
import '../model/materials_model.dart';

abstract class MaterialsRepository {
  Future<void> addMaterial(MaterialsModel material);
  Future<List<InstructorMaterialModel>> getInstructorMaterials(String instructorId);
  Future<void> deleteMaterial(int materialId);
}