import '../../model/student_material_model.dart';

abstract class StudentMaterialRemoteDataSource {
  Future<List<StudentMaterialModel>> getSubjectMaterials(
      int subjectId);
}