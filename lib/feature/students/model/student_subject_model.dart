class StudentSubjectModel {
  final int id;
  final String code;
  final String arbName;
  final String engName;

  const StudentSubjectModel({
    required this.id,
    required this.code,
    required this.arbName,
    required this.engName,
  });

  factory StudentSubjectModel.fromJson(Map<String, dynamic> json) {
    return StudentSubjectModel(
      id: json['id'] ?? 0,
      code: json['code'] ?? '',
      arbName: json['arbName'] ?? '',
      engName: json['engName'] ?? '',
    );
  }
}