class StudentMaterialModel {
  final int subjectId;
  final String title;
  final String instructorName;

  const StudentMaterialModel({
    required this.subjectId,
    required this.title,
    required this.instructorName,
  });

  factory StudentMaterialModel.fromJson(Map<String, dynamic> json) {
    return StudentMaterialModel(
      subjectId: json['subjectId'] ?? 0,
      title: json['title'] ?? '',
      instructorName: json['instructor']['fullName'] ?? '',
    );
  }
}
