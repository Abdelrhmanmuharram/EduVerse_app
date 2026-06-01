import 'package:edusync_app/core/app_theme.dart';
import 'package:edusync_app/core/routes/app_routes.dart';
import 'package:edusync_app/core/view/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/services/navigation_service.dart';
import 'feature/admin/instructors/repository/instructor_repository.dart';
import 'feature/admin/instructors/viewmodel/instructor_viewmodel.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => InstructorViewModel(InstructorRepository()),
        ),
      ],
      child: EduSync(),
    ),
  );
}

class EduSync extends StatelessWidget {
  const EduSync({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigationService.navigatorKey,
      routes: AppRoutes.routes,
      initialRoute: SplashView.routeName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
    );
  }
}
