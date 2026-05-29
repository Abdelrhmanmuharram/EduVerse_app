import 'package:edusync_app/feature/admin/semesters/repository/semester_repository_Impl.dart';
import 'package:edusync_app/feature/admin/semesters/viewmodel/semester_viewmodel.dart';
import 'package:edusync_app/feature/admin/student/view/add_student_view.dart';
import 'package:edusync_app/feature/admin/home/view/admin_home_view.dart';
import 'package:edusync_app/feature/admin/instructors/view/instructor_details.dart';
import 'package:edusync_app/feature/admin/departments/view/departments_view.dart';
import 'package:edusync_app/feature/onboarding/view/onboarding_view.dart';
import 'package:edusync_app/feature/admin/student/view/students_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../feature/admin/departments/repository/department_repository_impl.dart';
import '../../feature/admin/departments/view/add_department_view.dart';
import '../../feature/admin/departments/view/edit_department_view.dart';
import '../../feature/admin/departments/viewmodel/departement_viewmodel.dart';
import '../../feature/admin/semesters/view/semesters_view.dart';
import '../../feature/admin/instructors/view/add_instructor_view.dart';
import '../../feature/admin/semesters/view/add_semester_view.dart';
import '../../feature/admin/instructors/view/admin_instructors_view.dart';
import '../../feature/admin/semesters/view/edit_semester_view.dart';
import '../../feature/admin/student/view/student_details_view.dart';
import '../../feature/auth/login/repository/login_repository.dart';
import '../../feature/auth/login/view/login_view.dart';
import '../../feature/instructors/view/screens/instructors_view.dart';
import '../../feature/auth/login/viewmodel/login_view_model.dart';
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
    '/departments': (_) => ChangeNotifierProvider(
      create: (_) => DepartmentViewModel(DepartmentRepositoryImpl()),
      child: const DepartmentsView(),
    ),
    '/semesters': (_) => ChangeNotifierProvider(
      create: (context) => SemesterViewModel(SemesterRepositoryImpl()),
      child: const SemestersView(),
    ),
    '/instructors': (_) => AdminInstructorsView(),
    '/add-instructor': (_) => AddInstructorView(),
    '/instructor-details': (_) => InstructorDetails(),
    '/instructors-view': (_) => InstructorsView(),
    '/student': (_) => StudentView(),
    '/splash': (_) => SplashView(),
    '/add-semester': (_) => AddSemester(),
    '/edit-semester': (_) => EditSemesterView(),
    '/add-department': (_) => AddDepartmentView(),
    '/edit-department': (_) => EditDepartmentView(),
  };
}
