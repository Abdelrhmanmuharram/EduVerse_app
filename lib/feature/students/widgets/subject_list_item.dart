import 'package:edusync_app/feature/students/widgets/subject_card_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/app_theme.dart';
import '../view_model/student_dashboard_view_model.dart';

class SubjectListItem extends StatelessWidget {
  final StudentDashboardViewModel vm;

  const SubjectListItem({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      backgroundColor: AppTheme.primaryLight,
      color: AppTheme.white,
      onRefresh: () async {
        await vm.getDashboard();
      },
      child: ListView.separated(
        itemCount: vm.dashboard?.subjectAttendances.length ?? 0,
        separatorBuilder: (_, _) => const SizedBox(height: 16),
        itemBuilder: (_, index) {
          final subject = vm.dashboard!.subjectAttendances[index];
          return SubjectCardItem(
            subjectName: subject.subjectEngName,
            attendance: subject.attendancePercentage,
            instructorName: vm.instructors[subject.subjectId] ?? 'Unknown',
            materialsCount: vm.materialsCount[subject.subjectId] ?? 0,
          );
        },
      ),
    );
  }
}
