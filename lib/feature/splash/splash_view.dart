import 'dart:async';
import 'package:edusync_app/core/app_theme.dart';
import 'package:edusync_app/feature/splash/splash_viewmodel.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  static const String routeName = '/splash';

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final SplashViewmodel viewModel = SplashViewmodel();
  double progress = 0.0;
  late Timer timer;

  SplashViewmodel viewmodel = SplashViewmodel();

  @override
  void initState() {
    super.initState();
    startLoading();
  }

  void startLoading() {
    timer = Timer.periodic(Duration(milliseconds: 50), (timer) async {
      setState(() {
        progress += 0.02;
      });
      if (progress >= 1) {
        timer.cancel();
        onLoadingFinished();
      }
    });
  }

  Future<void> onLoadingFinished() async {
    await Future.delayed(Duration(seconds: 2));

    final route = await viewModel.getNextRoute();

    if (!mounted) return;
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Spacer(),
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: AppTheme.white,
                shape: .circle,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    color: AppTheme.black.withAlpha(30),
                  ),
                ],
              ),
              child: Icon(Icons.school, size: 40, color: AppTheme.primaryLight),
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
                      color: AppTheme.primaryLight,
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
              style: TextStyle(color: AppTheme.secondText, fontSize: 14),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Initializing campus...",
                  style: TextStyle(color: AppTheme.secondText),
                ),
                Text(
                  "${(progress * 100).toInt()}%",
                  style: TextStyle(
                    color: AppTheme.primaryLight,
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
