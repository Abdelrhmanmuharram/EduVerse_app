import '../../model/instructor_material_model.dart';
import '../../model/materials_model.dart';
import '../../model/update_material_model.dart';

abstract class MaterialsRemoteDataSource {
  Future<void> addMaterial(MaterialsModel material);
  Future<List<InstructorMaterialModel>> getInstructorMaterials(String instructorId);
  Future<void> updateMaterial(UpdateMaterialModel material);
  Future<void> deleteMaterial(int materialId);
}