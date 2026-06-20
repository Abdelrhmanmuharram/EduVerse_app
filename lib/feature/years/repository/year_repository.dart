import '../model/year_model.dart';

abstract class YearRepository {
  Future<List<YearModel>> getYears();
  Future<void> addYear(YearModel year);
  Future<void> updateYear(int id,YearModel year);
  Future<void> deleteYear(int id);
}