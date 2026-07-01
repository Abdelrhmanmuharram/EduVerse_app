import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/app_theme.dart';
import '../view_model/student_subject_details_view_model.dart';
import 'attendance_item.dart';

class AttendanceHistoryItem extends StatelessWidget {
  const AttendanceHistoryItem({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<StudentSubjectDetailsViewModel>();
    final visibleItems = vm.attendanceHistory.length > 2
        ? 2
        : vm.attendanceHistory.length;
    if (vm.attendanceHistory.isEmpty) {
      return Container(
        width: double.infinity,
        height: 180,
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppTheme.hintText, width: 1),
        ),
        child: const Center(child: Text('No attendance records yet')),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppTheme.hintText, width: 1),
      ),
      child: SizedBox(
        height: visibleItems * 110 + (visibleItems - 1) * 8,
        child: ListView.separated(
          itemCount: vm.attendanceHistory.length,
          separatorBuilder: (_, _) => const SizedBox(height: 8),
          itemBuilder: (_, index) {
            return AttendanceItem(attendance: vm.attendanceHistory[index]);
          },
        ),
      ),
    );
  }
}
