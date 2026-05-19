import 'package:dio/dio.dart';
import 'package:edusync_app/core/services/local_storage_service.dart';
import 'package:edusync_app/feature/login/repository/login_repository.dart';
import 'package:edusync_app/feature/login/viewmodel/roles.dart';
import 'package:flutter/material.dart';

import '../model/login_model.dart';

class LoginViewModel extends ChangeNotifier {
  final LoginRepository repo;
  LoginViewModel(this.repo);

  Future<String?> testLogin({
    required String email,
    required String password,
  }) async {
    try {
      print("EMAIL: $email");
      print("PASSWORD: $password");

      final result = await repo.login(
        email: email.trim(),
        password: password.trim(),
      );
      if (result.accessToken != null) {
        await LocalStorageService.saveToken(result.accessToken!);
        await LocalStorageService.saveRole(result.roles.first);
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
    } catch (e) {
      print("RAW ERROR: $e");
      String message = e.toString()
          .replaceAll("Exception:", "")
          .replaceAll("exception:", "")
          .trim();
      final lower = message.toLowerCase();
      if (lower.contains("emailorpasswordisincorrect")) {
        message = "Invalid email or password";
      } else if (lower.contains("usernotfound")) {
        message = "User not found";
      } else if (lower.contains("validationfailed")) {
        message = "Invalid input data";
      } else if (lower.contains("network")) {
        message = "Check your internet connection";
      } else {
        message = "Something went wrong";
      }
      print("FINAL MESSAGE: $message");
      throw message;
    }
  }

}
