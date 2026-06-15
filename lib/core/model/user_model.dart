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
  UserModel copyWith({
    String? id,
    String? fullName,
    String? email,
    bool? emailConfirmed,
    int? departmentId,
    int? yearId,
    List<String>? roles,
    bool? isActive,
  }) {
    return UserModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      emailConfirmed: emailConfirmed ?? this.emailConfirmed,
      departmentId: departmentId ?? this.departmentId,
      yearId: yearId ?? this.yearId,
      roles: roles ?? this.roles,
      isActive: isActive ?? this.isActive,
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
