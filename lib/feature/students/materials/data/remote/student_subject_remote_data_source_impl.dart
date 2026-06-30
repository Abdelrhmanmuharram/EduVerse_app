import 'package:edusync_app/core/constants/api_constants.dart';
import 'package:edusync_app/core/network/dio_client.dart';
import 'package:edusync_app/feature/students/materials/data/remote/student_subject_remote_data_source.dart';

import '../../model/student_subject_model.dart';

class StudentSubjectRemoteDataSourceImpl
    implements StudentSubjectRemoteDataSource {
  @override
  Future<List<StudentSubjectModel>> getSubjects({
    required int yearId,
    required int semesterId,
    required int departmentId,
  }) async {
    final response = await DioClient.dio.get(
      '${APIConstants.departmentYearSemesterSubjects}/$departmentId/$semesterId/$yearId',
    );
    return (response.data['data'] as List)
        .map((e) => StudentSubjectModel.fromJson(e))
        .toList();
  }
}
