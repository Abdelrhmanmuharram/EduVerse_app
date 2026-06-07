class AddStudentModel {
  final String? avatar;
  final String? id;
  final String fullName;
  final String email;
  final String password;
  final String role;
  final int departmentId;
  final int yearId;

  AddStudentModel({
    this.avatar,
    this.id,
    required this.fullName,
    required this.email,
    required this.password,
    required this.role,
    required this.departmentId,
    required this.yearId,
  });

  factory AddStudentModel.fromJson(Map<String, dynamic> json) {
    return AddStudentModel(
      fullName: json['fullName'],
      email: json['email'],
      password: json['password'],
      role: json['role'],
      departmentId: json['departmentId'],
      yearId: json['yearId'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'password': password,
      'role': role,
      'departmentId': departmentId,
      'yearId': yearId,
    };
  }
}
