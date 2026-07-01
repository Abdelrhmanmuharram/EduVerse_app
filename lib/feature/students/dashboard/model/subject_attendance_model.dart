class SubjectAttendanceModel {
  final int subjectId;
  final String subjectArbName;
  final String subjectEngName;
  final int presentCount;
  final int absentCount;
  final int totalSessions;
  final double attendancePercentage;
  final String status;

  SubjectAttendanceModel({
    required this.subjectId,
    required this.subjectArbName,
    required this.subjectEngName,
    required this.presentCount,
    required this.absentCount,
    required this.totalSessions,
    required this.attendancePercentage,
    required this.status,
  });

  factory SubjectAttendanceModel.fromJson(Map<String, dynamic> json) {
    return SubjectAttendanceModel(
      subjectId: json['subjectId'],
      subjectArbName: json['subjectArbName'],
      subjectEngName: json['subjectEngName'],
      presentCount: json['presentCount'],
      absentCount: json['absentCount'],
      totalSessions: json['totalSessions'],
      attendancePercentage:
      (json['attendancePercentage'] as num).toDouble(),
      status: json['status'],
    );
  }
}