import '../model/year_model.dart';

abstract class YearRepository {
  Future<List<YearModel>> getYears();
}