class DepartmentModel {
  final int id;
  final String arabicName;
  final String englishName;

  DepartmentModel({
    required this.id,
    required this.arabicName,
    required this.englishName,
  });

  factory DepartmentModel.fromJson(Map<String, dynamic> json) {
    return DepartmentModel(
      id: json['id'],
      arabicName: json['arbName'],
      englishName: json['engName'],
    );
  }
  Map<String, dynamic> toJson() {
    return {'id': id, 'arbName': arabicName, 'engName': englishName};
  }
}
