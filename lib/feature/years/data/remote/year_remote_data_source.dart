import '../../model/year_model.dart';

abstract class YearRemoteDataSource {
  Future<List<YearModel>>  getYears();
}