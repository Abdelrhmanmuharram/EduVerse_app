import 'package:edusync_app/feature/years/model/year_model.dart';
import 'package:edusync_app/feature/years/repository/year_repository.dart';

import '../data/remote/year_remote_data_source.dart';

class YearRepositoryImpl implements YearRepository {
  final YearRemoteDataSource _remoteDataSource;
  YearRepositoryImpl(this._remoteDataSource);
  @override
  Future<List<YearModel>> getYears() {
    return _remoteDataSource.getYears();
  }

  @override
  Future<void> addYear(YearModel year) {
    return _remoteDataSource.addYear(year);
  }

  @override
  Future<void> deleteYear(int id) {
    return _remoteDataSource.deleteYear(id);
  }

  @override
  Future<void> updateYear(int id,YearModel year) {
    return _remoteDataSource.updateYear(id, year);
  }
}
