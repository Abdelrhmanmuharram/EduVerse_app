import 'package:edusync_app/core/app_theme.dart';
import 'package:flutter/material.dart';

class DefaultLogo extends StatelessWidget {
  final double size;

  const DefaultLogo({super.key, this.size = 72});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Icon(
          Icons.school_outlined,
          color: AppTheme.primaryLight,
          size: size * 0.5,
        ),
      ),
    );
  }
}
