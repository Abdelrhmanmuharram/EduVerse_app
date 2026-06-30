import 'package:edusync_app/core/app_theme.dart';
import 'package:flutter/material.dart';

class DashboardHeader extends StatelessWidget {
  final String studentName;
  const DashboardHeader({super.key, required this.studentName});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundImage: AssetImage('assets/images/avatar.jpg'),
            ),
            const SizedBox(width: 14),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: 'Edu', style: textTheme.headlineSmall),
                  TextSpan(
                    text: 'Verse',
                    style: textTheme.headlineSmall!.copyWith(
                      color: AppTheme.primaryLight,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text('👋  Welcome back, $studentName', style: textTheme.headlineMedium),
        const SizedBox(height: 12),
      ],
    );
  }
}
