import 'package:edusync_app/feature/years/data/remote/year_remote_data_source.dart';
import 'package:edusync_app/feature/years/model/year_model.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/dio_client.dart';

class YearRemoteDataSourceImpl implements YearRemoteDataSource{
  @override
  Future<List<YearModel>> getYears() {
    final response = DioClient.dio.get(APIConstants.years, queryParameters: {
      'skip' : 0,
      'take' : 2147483647,
    });
    return response.then((value) {
      final List data = value.data['data'];
      return data.map((item) => YearModel.fromJson(item)).toList();
    });
  }
}