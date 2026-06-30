import 'package:edusync_app/feature/students/semester/model/system_setting_model.dart';

abstract class SystemSettingRepository {
  Future<SystemSettingModel> getSystemSetting();
}
