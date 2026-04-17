import 'package:edusync_app/core/app_theme.dart';
import 'package:flutter/material.dart';

class AttendanceSummaryCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: const [
          Icon(
            Icons.groups,
            color: AppTheme.primaryLight,
          ),          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("View Attendance History"),
                Text(
                  "Last entry: Today, 10:30 AM",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 16),
        ],
      ),
    );
  }
}