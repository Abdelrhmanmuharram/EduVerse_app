import 'package:edusync_app/core/app_theme.dart';
import 'package:flutter/material.dart';

class StudentHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text('Students', style: textTheme.headlineMedium),
        Text(
          'University registration management',
          style: textTheme.titleSmall!.copyWith(color: AppTheme.secondText),
        ),
      ],
    );
  }
}
