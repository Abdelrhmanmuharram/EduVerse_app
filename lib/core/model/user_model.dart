class UserModel {
  final String id;
  final String fullName;
  final String email;
  final bool emailConfirmed;
  final int? departmentId;
  final int? yearId;
  final List<String> roles;
  final bool isActive;

  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.emailConfirmed,
    required this.departmentId,
    required this.yearId,
    required this.roles,
    required this.isActive,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      emailConfirmed: json['emailConfirmed'] ?? false,
      departmentId: json['departmentId'],
      yearId: json['yearId'],
      roles: List<String>.from(json['roles'] ?? []),
      isActive: json['isActive'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'emailConfirmed': emailConfirmed,
      'departmentId': departmentId,
      'yearId': yearId,
      'roles': roles,
      'isActive': isActive,
    };
  }
}