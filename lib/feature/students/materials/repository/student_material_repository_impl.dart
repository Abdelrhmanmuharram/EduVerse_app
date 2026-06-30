import 'package:edusync_app/feature/students/materials/repository/student_material_repository.dart';

import '../data/remote/student_material_remote_data_source.dart';
import '../model/student_material_model.dart';

class StudentMaterialRepositoryImpl implements StudentMaterialRepository {
  final StudentMaterialRemoteDataSource _remote;
  StudentMaterialRepositoryImpl(this._remote);

  @override
  Future<List<StudentMaterialModel>> getSubjectMaterials(int subjectId) {
    return _remote.getSubjectMaterials(subjectId);
  }
}
