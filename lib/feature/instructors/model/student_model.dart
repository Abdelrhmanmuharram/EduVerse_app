class StudentModel {
  final String id;
  final String name;
  final String email;
  final String status;

  StudentModel({
    required this.id,
    required this.name,
    required this.email,
    required this.status,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      status: json["status"],
    );
  }
}
