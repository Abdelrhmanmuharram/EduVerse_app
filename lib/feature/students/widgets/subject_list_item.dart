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
        await vm.loadData();
      },
      child: ListView.separated(
        itemCount: vm.filteredSubjects.length,
        separatorBuilder: (_, _) => const SizedBox(height: 16),
        itemBuilder: (_, index) {
          final subject = vm.filteredSubjects[index];
          final attendance = vm.getAttendanceBySubjectId(subject.id);
          return SubjectCardItem(
            subject: subject,
            subjectName: subject.subjectName,
            attendance: attendance?.attendancePercentage ?? 0,
            instructorName: vm.instructors[subject.id] ?? [],
            materialsCount: vm.materialsCount[subject.id] ?? 0,
          );
        },
      ),
    );
  }
}
