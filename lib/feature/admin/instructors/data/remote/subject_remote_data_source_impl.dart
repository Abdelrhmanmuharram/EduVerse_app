import 'package:edusync_app/feature/admin/instructors/data/remote/subject_remote_data_source.dart';

import '../../../../../core/constants/api_constants.dart';
import '../../../../../core/network/dio_client.dart';
import '../../../student/model/subject_model.dart';
import '../../model/instructor_subject_model.dart';
import '../../model/instructor_subject_upsert_model.dart';

class SubjectRemoteDataSourceImpl implements SubjectRemoteDataSource {
  @override
  Future<List<SubjectModel>> getSubjects() async {
    final response = await DioClient.dio.get(
      '${APIConstants.baseUrl}/Subjects',
      queryParameters: {'skip': 0, 'take': 2147483647},
    );
    final data = response.data['data'] as List;
    return data.map((e) {
      return SubjectModel(id: e['id'], name: e['engName'], code: e['code']);
    }).toList();
  }

  @override
  Future<void> bulkUpsertSubjects(
    List<InstructorSubjectUpsertModel> subjects,
  ) async {
    await DioClient.dio.put(
      '${APIConstants.baseUrl}/InstructorSubjects/BulkUpsert',
      data: subjects.map((e) => e.toJson()).toList(),
    );
  }
}
