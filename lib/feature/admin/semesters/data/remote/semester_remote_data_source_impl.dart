import 'package:dio/dio.dart';

import '../../../../../core/constants/api_constants.dart';
import '../../../../../core/network/dio_client.dart';
import '../../../../../core/network/dio_error_handler.dart';
import '../../model/semester_model.dart';
import 'semester_remote_data_source.dart';

class SemesterRemoteDataSourceImpl implements SemesterRemoteDataSource {
  @override
  Future<List<SemesterModel>> getSemesters() async {
    final response = await DioClient.dio.get(
      APIConstants.semesters,
      queryParameters: {'skip': 0, 'take': 2147483647},
    );
    final List data = response.data['data'];
    return data.map((item) => SemesterModel.fromJson(item)).toList();
  }

  @override
  Future<void> addSemester(SemesterModel semester) async {
    await DioClient.dio.post(APIConstants.semesters, data: semester.toJson());
  }

  @override
  Future<void> deleteSemester(int id) async {
    try {
      await DioClient.dio.delete('${APIConstants.semesters}/$id');
    } on DioException catch (e) {
      throw DioErrorHandler.handle(e);
    }
  }

  @override
  Future<void> updateSemester(SemesterModel semester) async {
    await DioClient.dio.put(
      '${APIConstants.semesters}/${semester.id}',
      data: semester.toJson(),
    );
  }
}
