import 'package:edusync_app/feature/students/view/student_view.dart';
import 'package:flutter/material.dart';
import '../../feature/auth/login/view/login_view.dart';
import '../../feature/onboarding/view/onboarding_view.dart';
import '../services/local_storage_service.dart';
import '../../feature/admin/home/view/admin_home_view.dart';
import '../../feature/instructors/view/screens/instructors_view.dart';

class SplashView extends StatefulWidget {
  static const routeName = "/splash";

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _checkLogin();
  }
  Future<void> _checkLogin() async {
    final token = await LocalStorageService.getToken();
    final role = await LocalStorageService.getRole();
    final isSeen = await LocalStorageService.isOnboardingSeen();

    await Future.delayed(Duration(seconds: 1));
    if (!mounted) return;
    if(!isSeen){
      Navigator.pushReplacementNamed(context, OnboardingView.routeName);
      return;
    }
    if (token != null && role != null) {
      if (role == "Admin") {
        Navigator.pushReplacementNamed(context, AdminHomeView.routeName);
      } else if (role == "Instructor") {
        Navigator.pushReplacementNamed(context, InstructorsView.routeName);
      } else if (role == "Student") {
        Navigator.pushReplacementNamed(context, StudentView.routeName);
      }
    } else {
      Navigator.pushReplacementNamed(context, LoginView.routeName);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}