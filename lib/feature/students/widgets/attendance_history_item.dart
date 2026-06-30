import 'package:flutter/material.dart';

import '../../../core/app_theme.dart';
import 'attendance_item.dart';

class AttendanceHistoryItem extends StatelessWidget {
  const AttendanceHistoryItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppTheme.hintText, width: 1),
      ),
      child: SizedBox(
        height: (110 * 2) + 8,
        child: ListView.separated(
          itemBuilder: (_, _) => AttendanceItem(),
          separatorBuilder: (_, _) => SizedBox(height: 8),
          itemCount: 4,
        ),
      ),
    );
  }
}
