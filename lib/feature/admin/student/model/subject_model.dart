class SubjectModel {
  final int id;
  final String name;
  final String code;

  SubjectModel({
    required this.id,
    required this.name,
    required this.code,
  });

  factory SubjectModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return SubjectModel(
      id: json['id'],
      name: json['engName'] ?? '',
      code: json['code'] ?? '',
    );
  }
}