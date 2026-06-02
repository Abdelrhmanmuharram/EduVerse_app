class YearModel {
  final int id;
  final String arabicName;
  final String englishName;

  YearModel({
    required this.id,
    required this.arabicName,
    required this.englishName,
  });
  factory YearModel.fromJson(Map<String, dynamic> json) {
    return YearModel(
      id: json['id'],
      arabicName: json['arbName'],
      englishName: json['engName'],
    );
  }
  Map<String, dynamic> toJson() {
    return {'id': id, 'arbName': arabicName, 'engName': englishName};
  }
}
