import '../model/student_dashboard_model.dart';

abstract class StudentDashboardRepository {
  Future<StudentDashboardModel> getDashboard();
}