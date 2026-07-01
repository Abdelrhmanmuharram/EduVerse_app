import 'package:edusync_app/feature/students/dashboard/model/student_dashboard_model.dart';
import 'package:edusync_app/feature/students/dashboard/repository/student_dashboard_repository.dart';
import '../data/remote/student_dashboard_remote_data_source.dart';

class StudentDashboardRepositoryImpl implements StudentDashboardRepository {
  final StudentDashboardRemoteDataSource _remoteDataSource;
  StudentDashboardRepositoryImpl(this._remoteDataSource);

  @override
  Future<StudentDashboardModel> getDashboard() {
    return _remoteDataSource.getDashboard();
  }
}