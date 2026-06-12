import 'package:dio/dio.dart';
import 'package:edusync_app/feature/admin/instructors/data/remote/instructor_subject_remote_data_source.dart';
import 'package:edusync_app/feature/admin/student/model/subject_model.dart';

import '../../../../../core/constants/api_constants.dart';
import '../../../../../core/network/dio_client.dart';
import '../../model/instructor_subject_model.dart';
import '../../model/instructor_subject_upsert_model.dart';

class InstructorSubjectRemoteDataSourceImpl
    implements InstructorSubjectRemoteDataSource {
  @override
  Future<List<InstructorSubjectModel>> getInstructorSubjects(String instructorId) async {
    final response = await DioClient.dio.get(
      '${APIConstants.baseUrl}'
      '${APIConstants.getInstructorSubjects}'
      '/$instructorId',
    );
    final data = response.data['data'] as List;
    return data.map((e) {
      return InstructorSubjectModel(
        id: e['id'],
        instructorId: e['instructorId'],
        subjectId: e['subjectId'],
        subject: SubjectModel.fromJson(e['subject']),
      );
    }).toList();
  }

  @override
  Future<void> bulkUpsertSubjects(
    List<InstructorSubjectUpsertModel> subjects,
  ) async {
    try {
      final body = subjects.map((e) => e.toJson()).toList();
      print('BODY = $body');
      final response = await DioClient.dio.put(
        '${APIConstants.baseUrl}/InstructorSubjects/BulkUpsert',
        data: body,
      );
      print(response.data);
    } on DioException catch (e) {
      print('STATUS = ${e.response?.statusCode}');
      print('ERROR = ${e.response?.data}');
      rethrow;
    }
  }
}
