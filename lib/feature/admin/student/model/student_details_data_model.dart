class StudentDetailsData {
  final String originalFullName;
  final int? originalDepartmentId;
  final int? originalYearId;

  String currentFullName;
  int? currentDepartmentId;
  int? currentYearId;

  StudentDetailsData({
    required this.originalFullName,
    required this.originalDepartmentId,
    required this.originalYearId,
    required this.currentFullName,
    required this.currentDepartmentId,
    required this.currentYearId,
  });
}
