class SemesterModel {
  final int id;
  final String arbName;
  final String engName;

  const SemesterModel({
    required this.id,
    required this.arbName,
    required this.engName,
  });

  factory SemesterModel.fromJson(Map<String, dynamic> json) {
    return SemesterModel(
      id: json['id'] ?? 0,
      arbName: json['arbName'] ?? '',
      engName: json['engName'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {'id': id, 'arbName': arbName, 'engName': engName};
  }
}
