import 'package:edusync_app/feature/admin/materials/view/materials_view.dart';
import 'package:edusync_app/feature/admin/semesters/repository/semester_repository_Impl.dart';
import 'package:edusync_app/feature/admin/semesters/viewmodel/semester_viewmodel.dart';
import 'package:edusync_app/feature/admin/student/view/add_student_view.dart';
import 'package:edusync_app/feature/admin/home/view/admin_home_view.dart';
import 'package:edusync_app/feature/admin/instructors/view/instructor_details.dart';
import 'package:edusync_app/feature/admin/departments/view/departments_view.dart';
import 'package:edusync_app/feature/admin/student/viewmodel/student_viewmodel.dart';
import 'package:edusync_app/feature/admin/years/view/years_view.dart';
import 'package:edusync_app/feature/instructors/view/screens/instructors_home_view.dart';
import 'package:edusync_app/feature/onboarding/view/onboarding_view.dart';
import 'package:edusync_app/feature/admin/student/view/students_view.dart';
import 'package:edusync_app/feature/users/repository/users_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../feature/admin/departments/data/remote/department_remote_data_source_impl.dart';
import '../../feature/admin/departments/repository/department_repository_impl.dart';
import '../../feature/admin/departments/view/add_department_view.dart';
import '../../feature/admin/departments/view/edit_department_view.dart';
import '../../feature/admin/departments/viewmodel/departement_viewmodel.dart';
import '../../feature/admin/instructors/data/remote/instructor_subject_remote_data_source_impl.dart';
import '../../feature/admin/instructors/data/remote/subject_remote_data_source_impl.dart';
import '../../feature/admin/instructors/repository/instructor_repository.dart';
import '../../feature/admin/instructors/repository/instructor_subject_repository_impl.dart';
import '../../feature/admin/instructors/repository/subject_repository_impl.dart';
import '../../feature/admin/instructors/viewmodel/instructor_viewmodel.dart';
import '../../feature/admin/materials/data/remote/materials_admin_remote_source_imp.dart';
import '../../feature/admin/materials/repository/materials_admin_repository_impl.dart';
import '../../feature/admin/materials/view/add_materials_admin_view.dart';
import '../../feature/admin/materials/view/materials_admin_details_view.dart';
import '../../feature/admin/materials/view/pdf_viewer_screen.dart';
import '../../feature/admin/materials/view_model/materials_admin_view_model.dart';
import '../../feature/admin/materials/view_model/pdf_viewer_view_model.dart';
import '../../feature/admin/semesters/data/remote/semester_remote_data_source_impl.dart';
import '../../feature/admin/semesters/view/semesters_view.dart';
import '../../feature/admin/instructors/view/add_instructor_view.dart';
import '../../feature/admin/semesters/view/add_semester_view.dart';
import '../../feature/admin/instructors/view/admin_instructors_view.dart';
import '../../feature/admin/semesters/view/edit_semester_view.dart';
import '../../feature/admin/subject/data/remote/subjects_remote_data_source_impl.dart';
import '../../feature/admin/subject/repository/subjects_repository_impl.dart';
import '../../feature/admin/subject/view/add_subjects.dart';
import '../../feature/admin/subject/view/subjects_details.dart';
import '../../feature/admin/subject/view/subjects_view.dart';
import '../../feature/admin/subject/view_model/subject_view_model.dart';
import '../../feature/admin/years/view/add_years_view.dart';
import '../../feature/admin/years/view/years_details_view.dart';
import '../../feature/instructors/data/remote/materials_remote_data_source_impl.dart';
import '../../feature/instructors/repository/materials_repository_impl.dart';
import '../../feature/instructors/view/screens/instructor_view.dart';
import '../../feature/instructors/view/screens/material_add_view.dart';
import '../../feature/instructors/view/screens/materials_details_view.dart';
import '../../feature/instructors/view/screens/materials_view.dart';
import '../../feature/instructors/view/screens/students_list_view.dart';
import '../../feature/instructors/viewmodel/materials_viewmodel.dart';
import '../../feature/instructors/viewmodel/students_list_viewmodel.dart';
import '../../feature/years/data/remote/year_remote_data_source_impl.dart';
import '../../feature/years/repository/year_repository_impl.dart';
import '../../feature/years/viewmodel/year_viewmodel.dart';
import '../../feature/auth/login/data/remote/auth_remote_data_source_impl.dart';
import '../../feature/auth/login/repository/auth_repository.dart';
import '../../feature/auth/login/view/login_view.dart';
import '../../feature/auth/login/viewmodel/login_view_model.dart';
import '../../feature/students/view/student_view.dart';
import '../../feature/users/data/remote/users_remote_data_source_impl.dart';
import '../view/splash_view.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    OnboardingView.routeName: (_) => OnboardingView(),
    LoginView.routeName: (_) => ChangeNotifierProvider(
      create: (_) => LoginViewModel(AuthRepository(AuthRemoteDataSourceImpl())),
      child: LoginView(),
    ),
    AdminHomeView.routeName: (_) => AdminHomeView(),
    AddStudentView.routeName: (_) => AddStudentView(),
    '/students': (_) => MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) =>
              StudentViewModel(UsersRepositoryImpl(UsersRemoteDataSourceImpl()))
                ..loadStudents(),
        ),
        ChangeNotifierProvider(
          create: (_) => DepartmentViewModel(
            DepartmentRepositoryImpl(DepartmentRemoteDataSourceImpl()),
          )..loadDepartments(),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              YearViewmodel(YearRepositoryImpl(YearRemoteDataSourceImpl()))
                ..loadYears(),
        ),
      ],
      child: StudentsView(),
    ),
    '/departments': (_) => ChangeNotifierProvider(
      create: (_) => DepartmentViewModel(
        DepartmentRepositoryImpl(DepartmentRemoteDataSourceImpl()),
      )..loadDepartments(),
      child: const DepartmentsView(),
    ),
    '/semesters': (_) => ChangeNotifierProvider(
      create: (context) => SemesterViewModel(
        SemesterRepositoryImpl(SemesterRemoteDataSourceImpl()),
      )..loadSemesters(),
      child: const SemestersView(),
    ),
    '/instructors': (_) => MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => InstructorViewModel(
            UsersRepositoryImpl(UsersRemoteDataSourceImpl()),
            InstructorRepository(),
            InstructorSubjectRepositoryImpl(
              InstructorSubjectRemoteDataSourceImpl(),
            ),
            SubjectRepositoryImpl(SubjectRemoteDataSourceImpl()),
          )..loadInstructors(),
        ),

        ChangeNotifierProvider(
          create: (_) => DepartmentViewModel(
            DepartmentRepositoryImpl(DepartmentRemoteDataSourceImpl()),
          )..loadDepartments(),
        ),
      ],
      child: const AdminInstructorsView(),
    ),
    '/instructors-view': (_) => ChangeNotifierProvider(
      create: (_) => StudentsListViewModel(
        UsersRepositoryImpl(UsersRemoteDataSourceImpl()),
      )..loadStudents(),
      child: InstructorView(),
    ),
    '/add-instructor': (_) => AddInstructorView(),
    '/instructor-details': (_) => InstructorDetails(),
    '/students_list': (_) => MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => StudentsListViewModel(
            UsersRepositoryImpl(UsersRemoteDataSourceImpl()),
          )..loadStudents(),
        ),
      ],
      child: StudentsListView(),
    ),
    '/instructors-home': (_) => ChangeNotifierProvider(
      create: (_) => StudentsListViewModel(
        UsersRepositoryImpl(UsersRemoteDataSourceImpl()),
      )..loadStudents(),

      child: InstructorsHomeView(),
    ),
    '/student': (_) => const StudentView(),
    '/splash': (_) => const SplashView(),
    '/add-semester': (_) => const AddSemester(),
    '/edit-semester': (_) => const EditSemesterView(),
    '/add-department': (_) => const AddDepartmentView(),
    '/edit-department': (_) => const EditDepartmentView(),
    '/materials': (_) => const MaterialsView(),
    '/materials-details': (_) => const MaterialsDetails(),
    '/material-add': (_) => ChangeNotifierProvider(
      create: (_) => MaterialsViewModel(
        MaterialsRepositoryImpl(MaterialsRemoteDataSourceImpl()),
        InstructorSubjectRepositoryImpl(
          InstructorSubjectRemoteDataSourceImpl(),
        ),
      )..loadSubjects(),
      child: MaterialAddView(),
    ),
    '/years': (_) => ChangeNotifierProvider(
      create: (_) =>
          YearViewmodel(YearRepositoryImpl(YearRemoteDataSourceImpl()))
            ..loadYears(),
      child: YearsView(),
    ),
    '/years-details': (_) => ChangeNotifierProvider(
      create: (_) =>
          YearViewmodel(YearRepositoryImpl(YearRemoteDataSourceImpl()))
            ..loadYears(),
      child: YearsDetailsView(),
    ),
    '/add-years': (_) => ChangeNotifierProvider(
      create: (_) =>
          YearViewmodel(YearRepositoryImpl(YearRemoteDataSourceImpl()))
            ..loadYears(),
      child: const AddYearsView(),
    ),
    '/subjects': (_) => ChangeNotifierProvider(
      create: (_) => SubjectsViewModel(
        SubjectsRepositoryImpl(SubjectsRemoteDataSourceImpl()),
      )..loadSubjects(),
      child: SubjectsView(),
    ),
    '/subjects-details': (_) => MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SubjectsViewModel(
            SubjectsRepositoryImpl(SubjectsRemoteDataSourceImpl()),
          )..loadSubjects(),
        ),
        ChangeNotifierProvider(
          create: (_) => DepartmentViewModel(
            DepartmentRepositoryImpl(DepartmentRemoteDataSourceImpl()),
          )..loadDepartments(),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              YearViewmodel(YearRepositoryImpl(YearRemoteDataSourceImpl()))
                ..loadYears(),
        ),
        ChangeNotifierProvider(
          create: (_) => SemesterViewModel(
            SemesterRepositoryImpl(SemesterRemoteDataSourceImpl()),
          )..loadSemesters(),
        ),
      ],
      child: const SubjectsDetails(),
    ),
    '/add-subjects': (_) => MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SubjectsViewModel(
            SubjectsRepositoryImpl(SubjectsRemoteDataSourceImpl()),
          )..loadSubjects(),
        ),
        ChangeNotifierProvider(
          create: (_) => DepartmentViewModel(
            DepartmentRepositoryImpl(DepartmentRemoteDataSourceImpl()),
          )..loadDepartments(),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              YearViewmodel(YearRepositoryImpl(YearRemoteDataSourceImpl()))
                ..loadYears(),
        ),
        ChangeNotifierProvider(
          create: (_) => SemesterViewModel(
            SemesterRepositoryImpl(SemesterRemoteDataSourceImpl()),
          )..loadSemesters(),
        ),
      ],
      child: const AddSubjects(),
    ),

    '/materials-admin': (_) => ChangeNotifierProvider(
      create: (_) => MaterialAdminViewModel(
        MaterialsAdminRepositoryImpl(MaterialsAdminRemoteSourceImpl()),
        InstructorSubjectRepositoryImpl(
          InstructorSubjectRemoteDataSourceImpl(),
        ),
      )..loadMaterials(),
      child: MaterialsAdminView(),
    ),
    '/add-materials-admin': (_) => MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SubjectsViewModel(
            SubjectsRepositoryImpl(SubjectsRemoteDataSourceImpl()),
          )..loadSubjects(),
        ),
        ChangeNotifierProvider(
          create: (_) => InstructorViewModel(
            UsersRepositoryImpl(UsersRemoteDataSourceImpl()),
            InstructorRepository(),
            InstructorSubjectRepositoryImpl(
              InstructorSubjectRemoteDataSourceImpl(),
            ),
            SubjectRepositoryImpl(SubjectRemoteDataSourceImpl()),
          )..loadInstructors(),
        ),
        ChangeNotifierProvider(
          create: (_) => MaterialAdminViewModel(
            MaterialsAdminRepositoryImpl(
              MaterialsAdminRemoteSourceImpl(),
            ),
            InstructorSubjectRepositoryImpl(
              InstructorSubjectRemoteDataSourceImpl(),
            ),
          ),
        ),
      ],
      child: const AddMaterialsAdminView(),
    ),
  };
}
