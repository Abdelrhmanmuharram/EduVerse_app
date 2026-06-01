
import '../../../../../core/constants/api_constants.dart';
import '../../../../../core/network/dio_client.dart';
import '../../model/login_model.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<LoginModel> login({
    required String email,
    required String password,
  }) async {
    final response = await DioClient.dio.post(
      APIConstants.login,
      data: {
        "email": email,
        "password": password,
      },
    );

    return LoginModel.fromJson(response.data);
  }

  @override
  Future<void> logout(String userId) async {
    await DioClient.dio.post(
      APIConstants.logout,
      data: {
        "userId": userId,
      },
    );
  }
}