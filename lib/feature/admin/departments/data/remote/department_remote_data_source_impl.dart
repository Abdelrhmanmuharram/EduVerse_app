import 'package:dio/dio.dart';
import 'package:edusync_app/core/network/dio_error_handler.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../core/constants/api_constants.dart';
import '../../../../../core/network/dio_client.dart';
import '../../model/department_model.dart';
import 'department_remote_data_source.dart';

class DepartmentRemoteDataSourceImpl implements DepartmentRemoteDataSource {
  @override
  Future<List<DepartmentModel>> getDepartment() async {
    try {
      final response = await DioClient.dio.get(
        APIConstants.departments,
        queryParameters: {
          'skip': 0,
          'take': 2147483647,
        },
      );
      debugPrint('STATUS CODE = ${response.statusCode}');
      debugPrint('RESPONSE DATA = ${response.data}');
      final List data = response.data['data'];
      return data.map((item) =>
          DepartmentModel.fromJson(item)
      ).toList();

    } catch (e) {
      debugPrint('GET DEPARTMENTS ERROR');
      debugPrint(e as String?);
      rethrow;
    }
  }

  @override
  Future<void> addDepartment(DepartmentModel department) async {
    try {
      await DioClient.dio.post(
        APIConstants.departments,
        data: department.toJson(),
      );
    } on DioException catch (e) {
      throw DioErrorHandler.handle(e);
    }
  }

  @override
  Future<void> deleteDepartment(int id) async {
    try {
      await DioClient.dio.delete('${APIConstants.departments}/$id');
    } on DioException catch (e) {
      throw DioErrorHandler.handle(e);
    }
  }

  @override
  Future<void> updateDepartment(DepartmentModel department) async {
    try {
      await DioClient.dio.put(
        '${APIConstants.departments}/${department.id}',
        data: department.toJson(),
      );
    } on DioException catch (e) {
      throw DioErrorHandler.handle(e);
    }
  }
}
