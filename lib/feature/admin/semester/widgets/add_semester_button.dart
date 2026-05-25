import 'package:edusync_app/core/app_theme.dart';
import 'package:flutter/material.dart';

import '../model/semester_model.dart';

class AddSemesters extends StatefulWidget {
  final VoidCallback onTap;
  const AddSemesters({super.key, required this.onTap});

  @override
  State<AddSemesters> createState() => _AddSemestersState();
}

class _AddSemestersState extends State<AddSemesters> {
  List<SemesterModel> semesters = [];
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppTheme.primaryLight,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Text(
              'Add',
              style: textTheme.titleMedium!.copyWith(color: AppTheme.white),
            ),
            Icon(Icons.add, color: AppTheme.white),
          ],
        ),
      ),
    );
  }
}
