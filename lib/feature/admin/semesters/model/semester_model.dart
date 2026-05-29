class SemesterModel {
  final int id;
  final String arabicName;
  final String englishName;

  SemesterModel({
    required this.id,
    required this.arabicName,
    required this.englishName,
  });
  factory SemesterModel.fromJson(Map<String, dynamic> json) {
    return SemesterModel(
      id: json['id'],
      arabicName: json['arbName'],
      englishName: json['engName'],
    );
  }
  Map<String, dynamic> toJson() {
    return {'arbName': arabicName, 'engName': englishName};
  }
}
