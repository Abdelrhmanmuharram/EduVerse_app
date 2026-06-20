import 'package:edusync_app/core/network/dio_client.dart';

import 'package:edusync_app/feature/admin/student/model/subject_model.dart';
import 'package:edusync_app/feature/admin/subject/data/remote/subject_remote_data_source.dart';

import '../../../../../core/constants/api_constants.dart';

class SubjectRemoteDataSourceImpl implements SubjectsRemoteDataSource {
  @override
  Future<List<SubjectModel>> getSubjects() async {
    final response = await DioClient.dio.get(
      APIConstants.subjects,
      queryParameters: {'skip': 0, 'take': 2147483647},
    );
    return (response.data['data'] as List)
        .map((e) => SubjectModel.fromJson(e))
        .toList();
  }
}
