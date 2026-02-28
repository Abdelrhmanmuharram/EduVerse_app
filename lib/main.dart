import 'package:edusync_app/core/app_theme.dart';
import 'package:edusync_app/feature/login/login_view.dart';
import 'package:edusync_app/feature/onboarding/onboarding_view.dart';
import 'package:edusync_app/feature/splash/splash_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(EduSync());
}

class EduSync extends StatelessWidget {
  const EduSync({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        SplashView.routeName: (_) => SplashView(),
        OnboardingView.routeName: (_) => OnboardingView(),
        LoginView.routeName: (_) => LoginView(),
      },
      home: SplashView(),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
    );
  }
}
