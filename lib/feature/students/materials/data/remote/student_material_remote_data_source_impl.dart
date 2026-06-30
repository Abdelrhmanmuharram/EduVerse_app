import 'package:edusync_app/feature/students/materials/data/remote/student_material_remote_data_source.dart';

import '../../../../../core/constants/api_constants.dart';
import '../../../../../core/network/dio_client.dart';
import '../../model/student_material_model.dart';

class StudentMaterialRemoteDataSourceImpl
    implements StudentMaterialRemoteDataSource {
  @override
  Future<List<StudentMaterialModel>> getSubjectMaterials(int subjectId) async {
    final response = await DioClient.dio.get(
      '${APIConstants.subjectMaterials}/$subjectId',
    );
    print(response.data);
    return (response.data['data'] as List)
        .map((e) => StudentMaterialModel.fromJson(e))
        .toList();
  }
}
