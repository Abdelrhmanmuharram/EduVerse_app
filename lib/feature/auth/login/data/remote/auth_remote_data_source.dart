import '../../model/login_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginModel> login({
    required String email,
    required String password,
  });
  Future<void> logout(String userId);
}