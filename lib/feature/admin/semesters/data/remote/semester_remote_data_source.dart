import 'package:dio/dio.dart';

import '../../../../../core/constants/api_constants.dart';
import '../../../../../core/network/dio_client.dart';
import '../../../../../core/network/dio_error_handler.dart';
import '../../model/semester_model.dart';

abstract class SemesterRemoteDataSource {
  Future<List<SemesterModel>> getSemesters();
  Future<void> addSemester(SemesterModel semester);
  Future<void> deleteSemester(int id) async {
    try {
      await DioClient.dio.delete('${APIConstants.semesters}/$id');
    } on DioException catch (e) {
      throw Exception(
       throw DioErrorHandler.handle(e),
      );
    }
  }

  Future<void> updateSemester(SemesterModel semester);
}
