class LoginModel {
  final String? accessToken;
  final String? refreshToken;
  final List<String> roles;

  LoginModel({this.accessToken, this.refreshToken, required this.roles});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return LoginModel(
      accessToken: data?['accessToken'],
      refreshToken: data?['refreshToken'],
      roles: List<String>.from(data?['roles'] ?? []),
    );
  }
}
