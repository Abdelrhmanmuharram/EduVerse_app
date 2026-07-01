class StudentMaterialModel {
  final int id;
  final int subjectId;
  final String title;
  final String? description;
  final String filePath;
  final String publicId;
  final String instructorName;

  const StudentMaterialModel({
    required this.id,
    required this.subjectId,
    required this.title,
    this.description,
    required this.filePath,
    required this.publicId,
    required this.instructorName,
  });

  factory StudentMaterialModel.fromJson(Map<String, dynamic> json) {
    return StudentMaterialModel(
      id: json['id'],
      subjectId: json['subjectId'],
      title: json['title'] ?? '',
      description: json['description'],
      filePath: json['filePath'] ?? '',
      publicId: json['publicId'] ?? '',
      instructorName: json['instructor']['fullName'] ?? '',
    );
  }
}