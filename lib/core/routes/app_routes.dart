import 'package:edusync_app/feature/admin/student/view/add_student_view.dart';
import 'package:edusync_app/feature/admin/home/view/admin_home_view.dart';
import 'package:edusync_app/feature/admin/instructor/view/instructor_details.dart';
import 'package:edusync_app/feature/admin/department/view/departments_view.dart';
import 'package:edusync_app/feature/login/view/login_view.dart';
import 'package:edusync_app/feature/onboarding/view/onboarding_view.dart';
import 'package:edusync_app/feature/admin/student/view/students_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../feature/admin/semester/view/semesters_view.dart';
import '../../feature/admin/instructor/view/add_instructor_view.dart';
import '../../feature/admin/semester/view/add_semester_view.dart';
import '../../feature/admin/instructor/view/admin_instructors_view.dart';
import '../../feature/admin/semester/view/edit_semester_view.dart';
import '../../feature/admin/student/view/student_details_view.dart';
import '../../feature/instructors/view/screens/instructors_view.dart';
import '../../feature/login/repository/login_repository.dart';
import '../../feature/login/viewmodel/login_view_model.dart';
import '../../feature/students/view/student_view.dart';
import '../view/splash_view.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    OnboardingView.routeName: (_) => OnboardingView(),
    LoginView.routeName: (_) => ChangeNotifierProvider(
      create: (_) => LoginViewModel(LoginRepository()),
      child: LoginView(),
    ),
    AdminHomeView.routeName: (_) => AdminHomeView(),
    AddStudentView.routeName: (_) => AddStudentView(),
    StudentDetailsView.routeName: (_) => StudentDetailsView(),

    '/students': (_) => StudentsView(),
    '/departments': (_) => DepartmentsView(),
    '/semesters': (_) => SemestersView(),
    '/instructors': (_) => AdminInstructorsView(),
    '/add-instructor': (_) => AddInstructorView(),
    '/instructor-details': (_) => InstructorDetails(),
    '/instructors-view': (_) => InstructorsView(),
    '/student': (_) => StudentView(),
    '/splash': (_) => SplashView(),
    '/add-semester': (_) => AddSemester(),
    '/edit-semester': (_) => EditSemesterView(),
  };
}
