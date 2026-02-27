import 'package:edusync_app/core/app_theme.dart';
import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  static const String routeName = '/splash';

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
                  "75%",
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
                value: 0.75,
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
