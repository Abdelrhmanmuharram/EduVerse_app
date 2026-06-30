import '../model/student_material_model.dart';

abstract class StudentMaterialRepository {
  Future<List<StudentMaterialModel>> getSubjectMaterials(int subjectId);
}
