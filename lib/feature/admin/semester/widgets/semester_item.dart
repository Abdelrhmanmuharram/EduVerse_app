import 'package:edusync_app/feature/admin/semester/model/semester_model.dart';
import 'package:edusync_app/feature/admin/semester/widgets/semester_item_action_button.dart';
import 'package:flutter/material.dart';

import '../../../../core/app_theme.dart';

class SemesterItem extends StatelessWidget {
  final SemesterModel semester;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  const SemesterItem({
    super.key,
    required this.semester,
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
            children: [Text(semester.arabicName), Text(semester.englishName)],
          ),
          Spacer(),
          SemesterItemActionButton(
            icon: Icons.edit,
            onTap: onEdit,
          ),
          SizedBox(width: 8),
          SemesterItemActionButton(icon: Icons.delete, onTap: onDelete),
        ],
      ),
    );
  }
}
