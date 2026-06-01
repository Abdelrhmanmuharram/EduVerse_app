import '../../../../core/model/user_model.dart';

class LoginModel {
  final String? accessToken;
  final String? refreshToken;
  final String? expiresIn;
  final String? refreshTokenExpiration;
  final UserModel user;
  final List<String> roles;

  LoginModel({
    this.expiresIn,
    this.refreshTokenExpiration,
    this.accessToken,
    this.refreshToken,
    required this.roles,
    required this.user,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];

    return LoginModel(
      accessToken: data?['accessToken'],
      refreshToken: data?['refreshToken'],
      expiresIn: data?['expiresIn'],
      refreshTokenExpiration: data?['refreshTokenExpiration'],
      roles: List<String>.from(data?['roles'] ?? []),
      user: UserModel.fromJson(data),
    );
  }
}