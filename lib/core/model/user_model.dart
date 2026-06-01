class UserModel {
  final String id;
  final String fullName;
  final String email;
  final List<String> roles;

  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.roles,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      roles: List<String>.from(json['roles'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'roles': roles,
    };
  }
}