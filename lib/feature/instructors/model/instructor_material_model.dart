class InstructorMaterialModel {
  final int id;
  final int subjectId;
  final String instructorId;
  final String title;
  final String? description;
  final String filePath;
  final String publicId;

  final String subjectName;
  final String subjectCode;

  const InstructorMaterialModel({
    required this.id,
    required this.subjectId,
    required this.instructorId,
    required this.title,
    this.description,
    required this.filePath,
    required this.publicId,
    required this.subjectName,
    required this.subjectCode,
  });

  factory InstructorMaterialModel.fromJson(Map<String, dynamic> json) {
    return InstructorMaterialModel(
      id: json["id"],
      subjectId: json["subjectId"],
      instructorId: json["instructorId"],
      title: json["title"] ?? "",
      description: json["description"],
      filePath: json["filePath"] ?? "",
      publicId: json["publicId"] ?? "",
      subjectName: json["subject"]["engName"] ?? "",
      subjectCode: json["subject"]["code"] ?? "",
    );
  }
}