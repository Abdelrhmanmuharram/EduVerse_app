class UpdateMaterialModel {
  final int id;
  final String instructorId;
  final int subjectId;
  final String title;
  final String description;
  final String filePath;
  final String publicId;

  const UpdateMaterialModel({
    required this.id,
    required this.instructorId,
    required this.subjectId,
    required this.title,
    required this.description,
    required this.filePath,
    required this.publicId,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "instructorId": instructorId,
      "subjectId": subjectId,
      "title": title,
      "description": description,
      "filePath": filePath,
      "publicId": publicId,
    };
  }
}