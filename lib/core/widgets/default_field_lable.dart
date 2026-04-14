import 'package:edusync_app/core/app_theme.dart';
import 'package:flutter/material.dart';

class FieldLabel extends StatelessWidget {
  final String label;

  const FieldLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style:  TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppTheme.secondText,
      ),
    );
  }
}
