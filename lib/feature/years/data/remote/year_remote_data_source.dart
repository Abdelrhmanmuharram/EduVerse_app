import '../../model/year_model.dart';

abstract class YearRemoteDataSource {
  Future<List<YearModel>> getYears();
  Future<void> addYear(YearModel year);
  Future<void> updateYear(int id, YearModel year);
  Future<void> deleteYear(int id);
}