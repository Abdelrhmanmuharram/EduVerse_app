import 'package:flutter/material.dart';
import 'package:edusync_app/core/app_theme.dart';

class InstructorMenuCard extends StatelessWidget {

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback? onTap; // 🔥 ضيف دي

  const InstructorMenuCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.onTap, // 🔥 ضيف دي
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap, // 🔥 هنا بقى الكليك

      child: Container(
        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(16),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppTheme.backgroundLight,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: AppTheme.primaryLight),
            ),

            const SizedBox(height: 14),

            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 12,
                color: AppTheme.secondText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}