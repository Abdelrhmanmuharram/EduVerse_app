import 'package:edusync_app/core/constants/api_constants.dart';
import 'package:edusync_app/core/network/dio_client.dart';
import 'package:edusync_app/feature/students/data/remote/student_dashboard_remote_data_source.dart';
import 'package:edusync_app/feature/students/model/student_dashboard_model.dart';

class StudentDashboardRemoteDataSourceImpl
    implements StudentDashboardRemoteDataSource {
  @override
  Future<StudentDashboardModel> getDashboard() async {
    final response = await DioClient.dio.get(APIConstants.dashboard);
    return StudentDashboardModel.fromJson(response.data['data']);
  }
}
