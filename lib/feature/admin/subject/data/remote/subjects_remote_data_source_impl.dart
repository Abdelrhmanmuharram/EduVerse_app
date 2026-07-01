import 'package:edusync_app/core/network/dio_client.dart';

import 'package:edusync_app/feature/admin/student/model/subject_model.dart';
import 'package:edusync_app/feature/admin/subject/data/remote/subjects_remote_data_source.dart';

import '../../../../../core/constants/api_constants.dart';
import '../../model/subjects_model.dart';

class SubjectsRemoteDataSourceImpl implements SubjectsRemoteDataSource {
  @override
  Future<List<SubjectsModel>> getSubjects() async {
    final response = await DioClient.dio.get(
      APIConstants.subjects,
      queryParameters: {'skip': 0, 'take': 2147483647},
    );
    return (response.data['data'] as List)
        .map((e) => SubjectsModel.fromJson(e))
        .toList();
  }
  @override
  Future<void> addSubject(SubjectsModel subject) async {
    await DioClient.dio.post(APIConstants.subjects, data: subject.toJson());
  }

  @override
  Future<void> deleteSubject(int id) async {
    await DioClient.dio.delete('${APIConstants.subjects}/$id');
  }

  @override
  Future<void> updateSubject(int id, SubjectsModel subject) async {
    await DioClient.dio.put(
      '${APIConstants.subjects}/$id',
      data: subject.toJson(),
    );
  }

  @override
  Future<String> getNextCode() async {
    final response = await DioClient.dio.get(
      '${APIConstants.subjects}/GetNextCode',
    );
    return response.data['data'].toString();
  }
}
