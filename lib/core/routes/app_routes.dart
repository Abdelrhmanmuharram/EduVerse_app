import 'package:edusync_app/feature/admin/view/screens/add_student_view.dart';
import 'package:edusync_app/feature/admin/view/screens/admin_home_view.dart';
import 'package:edusync_app/feature/departments/departments_view.dart';
import 'package:edusync_app/feature/instructors/instructors_view.dart';
import 'package:edusync_app/feature/login/view/login_view.dart';
import 'package:edusync_app/feature/onboarding/view/onboarding_view.dart';
import 'package:edusync_app/feature/semesters/semesters_view.dart';
import 'package:edusync_app/feature/admin/view/screens/students_view.dart';
import 'package:flutter/material.dart';

import '../../feature/admin/view/screens/student_details_view.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    OnboardingView.routeName: (_) => OnboardingView(),
    LoginView.routeName: (_) => LoginView(),
    AdminHomeView.routeName: (_) => AdminHomeView(),
    AddStudentView.routeName: (_) => AddStudentView(),
    StudentDetailsView.routeName: (_) => StudentDetailsView(),

    '/students': (_) => StudentsView(),
    '/departments': (_) => DepartmentsView(),
    '/semesters': (_) => SemestersView(),
    '/instructors': (_) => InstructorsView(),
  };
}
