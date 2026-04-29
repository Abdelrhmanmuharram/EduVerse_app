import 'package:edusync_app/core/app_theme.dart';
import 'package:edusync_app/core/routes/app_routes.dart';
import 'package:edusync_app/core/view/splash_view.dart';
import 'package:edusync_app/feature/admin/view/screens/admin_instructors_view.dart';
import 'package:edusync_app/feature/onboarding/view/onboarding_view.dart';
import 'package:flutter/material.dart';

import 'feature/admin/view/screens/admin_home_view.dart';
import 'feature/login/view/login_view.dart';

void main() {
  runApp(
      EduSync());
}

class EduSync extends StatelessWidget {
  const EduSync({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: AppRoutes.routes,
      initialRoute: SplashView.routeName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
    );
  }
}
