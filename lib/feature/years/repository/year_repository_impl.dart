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
}
