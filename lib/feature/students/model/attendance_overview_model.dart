class AttendanceOverviewModel {
  final int totalSessions;
  final int presentCount;
  final int absentCount;
  final double attendancePercentage;
  final String status;

  AttendanceOverviewModel({
    required this.totalSessions,
    required this.presentCount,
    required this.absentCount,
    required this.attendancePercentage,
    required this.status,
  });

  factory AttendanceOverviewModel.fromJson(Map<String, dynamic> json) {
    return AttendanceOverviewModel(
      totalSessions: json['totalSessions'],
      presentCount: json['presentCount'],
      absentCount: json['absentCount'],
      attendancePercentage: (json['attendancePercentage'] as num).toDouble(),
      status: json['status'],
    );
  }
}