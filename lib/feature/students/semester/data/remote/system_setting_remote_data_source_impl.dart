import 'package:edusync_app/core/constants/api_constants.dart';
import 'package:edusync_app/core/network/dio_client.dart';
import 'package:edusync_app/feature/students/semester/data/remote/system_setting_remote_data_source.dart';
import 'package:edusync_app/feature/students/semester/model/system_setting_model.dart';

class SystemSettingRemoteDataSourceImpl
    implements SystemSettingRemoteDataSource {
  @override
  Future<SystemSettingModel> getSystemSemester() async {
    final response = await DioClient.dio.get(APIConstants.systemSetting);
    return SystemSettingModel.fromJson(response.data['data']);
  }
}
