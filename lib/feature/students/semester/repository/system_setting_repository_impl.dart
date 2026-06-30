import 'package:edusync_app/feature/students/semester/model/system_setting_model.dart';
import 'package:edusync_app/feature/students/semester/repository/system_setting_repository.dart';

import '../data/remote/system_setting_remote_data_source.dart';

class SystemSettingRepositoryImpl implements SystemSettingRepository {
  final SystemSettingRemoteDataSource _remoteDataSource;
  SystemSettingRepositoryImpl(this._remoteDataSource);
  @override
  Future<SystemSettingModel> getSystemSetting() {
    return _remoteDataSource.getSystemSemester();
  }
}
