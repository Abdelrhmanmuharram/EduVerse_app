import 'package:edusync_app/feature/students/semester/model/system_setting_model.dart';

abstract class SystemSettingRemoteDataSource {
  Future<SystemSettingModel> getSystemSemester();
}
