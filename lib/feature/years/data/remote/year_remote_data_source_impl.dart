import 'package:edusync_app/feature/years/data/remote/year_remote_data_source.dart';
import 'package:edusync_app/feature/years/model/year_model.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/dio_client.dart';

class YearRemoteDataSourceImpl implements YearRemoteDataSource {
  @override
  Future<List<YearModel>> getYears() {
    final response = DioClient.dio.get(
      APIConstants.years,
      queryParameters: {'skip': 0, 'take': 2147483647},
    );
    return response.then((value) {
      final List data = value.data['data'];
      return data.map((item) => YearModel.fromJson(item)).toList();
    });
  }

  @override
  Future<void> addYear(YearModel year) async {
    await DioClient.dio.post(APIConstants.years, data: year.toJson());
  }

  @override
  Future<void> deleteYear(int id) async {
    await DioClient.dio.delete('${APIConstants.years}/$id');
  }

  @override
  Future<void> updateYear(int id, YearModel year) async {
    await DioClient.dio.put(
      "${APIConstants.years}/$id",
      data: year.toJson(),
    );
  }
}
