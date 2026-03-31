import 'package:edusync_app/feature/admin/view/screens/admin_home_view.dart';
import 'package:edusync_app/feature/departments/departments_view.dart';
import 'package:edusync_app/feature/instructors/instructors_view.dart';
import 'package:edusync_app/feature/login/view/login_view.dart';
import 'package:edusync_app/feature/onboarding/view/onboarding_view.dart';
import 'package:edusync_app/feature/semesters/semesters_view.dart';
import 'package:edusync_app/feature/splash/view/splash_view.dart';
import 'package:edusync_app/feature/students/students_view.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    SplashView.routeName: (_) => SplashView(),
    OnboardingView.routeName: (_) => OnboardingView(),
    LoginView.routeName: (_) => LoginView(),
    HomeAdmin.routeName: (_) => HomeAdmin(),

    '/students': (_) => StudentsView(),
    '/departments': (_) => DepartmentsView(),
    '/semesters': (_) => SemestersView(),
    '/instructors': (_) => InstructorsView(),
  };
}
