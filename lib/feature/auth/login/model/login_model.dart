class LoginModel {
  final String? accessToken;
  final String? refreshToken;
  final String? expiresIn;
  final String? refreshTokenExpiration;
  final List<String> roles;

  LoginModel({
    this.expiresIn,
    this.refreshTokenExpiration,
    this.accessToken,
    this.refreshToken,
    required this.roles,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return LoginModel(
      accessToken: data?['accessToken'],
      refreshToken: data?['refreshToken'],
      expiresIn: data?['expiresIn'],
      refreshTokenExpiration: data?['refreshTokenExpiration'],
      roles: List<String>.from(data?['roles'] ?? []),
    );
  }
}
