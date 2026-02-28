import 'dart:async';

import 'package:edusync_app/core/app_theme.dart';
import 'package:edusync_app/core/services/local_storage_service.dart';
import 'package:edusync_app/feature/login/login_view.dart';
import 'package:edusync_app/feature/onboarding/onboarding_view.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  static const String routeName = '/splash';

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  double progress = 0.0;
  late Timer timer;

  void initState() {
    startLoading();
  }

  void startLoading() {
    timer = Timer.periodic(Duration(milliseconds: 50), (timer) async {
      setState(() {
        progress += 0.02;
      });
      if (progress >= 1) {
        timer.cancel();

        await Future.delayed(Duration(seconds: 2));
        bool seen = await LocalStorageService.isOnboardingSeen();

        if (seen) {
          Navigator.pushNamed(context, LoginView.routeName);
        } else {
          Navigator.pushNamed(context, OnboardingView.routeName);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: .center,
          children: [
            const Spacer(),
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(blurRadius: 20, color: Colors.black.withAlpha(30)),
                ],
              ),
              child: Icon(Icons.school, size: 40, color: Color(0xFF3B82F6)),
            ),
            SizedBox(height: 24),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Edu",
                    style: TextStyle(
                      color: Color(0xFF0F172A),
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: "Sync",
                    style: TextStyle(
                      color: Color(0xFF3B82F6),
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Smart University Management",
              style: TextStyle(color: Color(0xFF64748B), fontSize: 14),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Initializing campus...",
                  style: TextStyle(color: Color(0xFF64748B)),
                ),
                Text(
                  "${(progress * 100).toInt()}%",
                  style: TextStyle(
                    color: Color(0xFF3B82F6),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(0),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 6,
                backgroundColor: Color(0xFFE2E8F0),
                color: AppTheme.primaryLight,
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
