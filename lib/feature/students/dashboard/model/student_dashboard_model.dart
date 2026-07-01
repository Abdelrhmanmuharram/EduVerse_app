import 'package:edusync_app/feature/students/dashboard/model/subject_attendance_model.dart';

import 'attendance_overview_model.dart';
import 'latest_material_model.dart';

class StudentDashboardModel {
  final AttendanceOverviewModel attendanceOverview;
  final List<SubjectAttendanceModel> subjectAttendances;
  final List<LatestMaterialModel> latestMaterials;

  StudentDashboardModel({
    required this.attendanceOverview,
    required this.subjectAttendances,
    required this.latestMaterials,
  });

  factory StudentDashboardModel.fromJson(Map<String, dynamic> json) {
    return StudentDashboardModel(
      attendanceOverview: AttendanceOverviewModel.fromJson(
        json['attendanceOverview'],
      ),
      subjectAttendances: (json['subjectAttendances'] as List)
          .map((e) => SubjectAttendanceModel.fromJson(e))
          .toList(),
      latestMaterials: (json['latestMaterials'] as List)
          .map((e) => LatestMaterialModel.fromJson(e))
          .toList(),
    );
  }
}