import '../data/remote/auth_remote_data_source.dart';
import '../model/login_model.dart';

class AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepository(this.remoteDataSource);

  Future<LoginModel> login({
    required String email,
    required String password,
  }) {
    return remoteDataSource.login(
      email: email,
      password: password,
    );
  }

  Future<void> logout(String userId) {
    return remoteDataSource.logout(userId);
  }
}