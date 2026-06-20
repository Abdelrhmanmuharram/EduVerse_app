import 'package:edusync_app/feature/admin/departments/model/department_model.dart';
import 'package:flutter/material.dart';

import '../../../../core/app_theme.dart';
import '../model/subjects_model.dart';

class SubjectsItem extends StatelessWidget {
  final SubjectsModel subjects;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const SubjectsItem({
    super.key,
    required this.subjects,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.blueGray.withAlpha(60)),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(subjects.arbName),
              Text(subjects.engName),
              Text("Code: ${subjects.code}"),
              Text(subjects.department.englishName),
              Text(subjects.year.engName),
              Text(subjects.semester.englishName),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: onEdit,
            child: Icon(Icons.edit, color: AppTheme.primaryLight),
          ),
          SizedBox(width: 8),
          GestureDetector(
            onTap: onDelete,
            child: Icon(Icons.delete, color: AppTheme.red),
          ),
        ],
      ),
    );
  }
}
