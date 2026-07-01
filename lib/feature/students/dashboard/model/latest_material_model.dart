class LatestMaterialModel {
  final int id;
  final String title;
  final String subjectName;
  final String instructorName;
  final String filePath;
  final DateTime createdAt;

  LatestMaterialModel({
    required this.id,
    required this.title,
    required this.subjectName,
    required this.instructorName,
    required this.filePath,
    required this.createdAt,
  });

  factory LatestMaterialModel.fromJson(Map<String, dynamic> json) {
    return LatestMaterialModel(
      id: json['id'],
      title: json['title'],
      subjectName: json['subjectName'],
      instructorName: json['instructorName'],
      filePath: json['filePath'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}