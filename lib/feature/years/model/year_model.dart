class YearModel {
  final int id;
  final String arbName;
  final String engName;

  YearModel({
    required this.id,
    required this.arbName,
    required this.engName,
  });
  factory YearModel.fromJson(Map<String, dynamic> json) {
    return YearModel(
      id: json['id'] ?? 0,
      arbName: json['arbName'] ?? '',
      engName: json['engName'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {'id': id, 'arbName': arbName, 'engName': engName};
  }
}
