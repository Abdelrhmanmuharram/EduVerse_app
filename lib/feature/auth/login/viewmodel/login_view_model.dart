import 'package:dio/dio.dart';
import 'package:edusync_app/core/services/local_storage_service.dart';
import 'package:edusync_app/feature/auth/login/viewmodel/roles.dart';
import 'package:flutter/material.dart';

import '../../../../core/services/navigation_service.dart';
import '../repository/auth_repository.dart';
import '../view/login_view.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthRepository repo;

  LoginViewModel(this.repo);

  Future<String?> testLogin({
    required String email,
    required String password,
  }) async {
    try {
      final result = await repo.login(
        email: email.trim(),
        password: password.trim(),
      );
      if (result.accessToken != null) {
        await LocalStorageService.saveToken(result.accessToken!);
        await LocalStorageService.saveRefreshToken(result.refreshToken!);
        await LocalStorageService.saveTokenExpiry(result.expiresIn!);
        await LocalStorageService.saveRefreshTokenExpiry(
          result.refreshTokenExpiration!,
        );
        await LocalStorageService.saveRole(result.roles.first);
        await LocalStorageService.saveUser(result.user);
      }
      final roles = result.roles;
      if (roles.contains(Roles.roleAdmin)) {
        return "/home";
      } else if (roles.contains(Roles.roleInstructor)) {
        return "/instructors-view";
      } else if (roles.contains(Roles.roleStudent)) {
        return "/student";
      }
      return null;
    } on DioException catch (e) {
      String message = 'Something went wrong';
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        message = 'Connection timeout';
      } else if (e.type == DioExceptionType.connectionError) {
        message = 'Check your internet connection';
      } else if (e.response != null) {
        final statusCode = e.response?.statusCode;
        final data = e.response?.data;
        if (statusCode == 401) {
          message = 'Invalid email or password';
        } else if (statusCode == 404) {
          message = 'User not found';
        } else if (statusCode == 400) {
          message = data['message'] ?? 'Invalid input data';
        } else if (statusCode == 500) {
          message = 'Server error';
        }
      }
      throw message;
    } catch (e) {
      String message = e
          .toString()
          .toLowerCase()
          .replaceAll("exception:", "")
          .trim();
      if (message.contains("emailorpassworisincorrect")) {
        throw "Invalid email or password";
      }
    }
    return null;
  }

  Future<void> logout() async {
    debugPrint('[AUTH] START LOGOUT');
    final user = await LocalStorageService.getUser();
    debugPrint(user?.id);
    if (user == null) return;
    await repo.logout(user.id);
    debugPrint('[AUTH] API SUCCESS');
    debugPrint('[PROFILE] USER LOADED');
    debugPrint('[DEPARTMENT] DATA LOADED');
    await LocalStorageService.clearUserData();
    debugPrint('LOCAL STORAGE CLEARED');
    NavigationService.pushNamedAndRemoveUntil(LoginView.routeName);
  }
}
