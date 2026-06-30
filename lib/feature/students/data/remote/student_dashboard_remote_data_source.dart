import '../../model/student_dashboard_model.dart';

abstract class StudentDashboardRemoteDataSource {
  Future<StudentDashboardModel> getDashboard();
}