import 'package:edusync_app/core/app_theme.dart';
import 'package:flutter/material.dart';

class StudentsHeaderTable extends StatelessWidget {
  final int total;

  const StudentsHeaderTable({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "STUDENT DIRECTORY",
          style: textTheme.titleSmall!.copyWith(
            fontSize: 14,
            color: AppTheme.secondText,
            fontWeight: .w600,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xffE7ECFF),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            "$total Total",
            style: textTheme.titleSmall!.copyWith(
              fontSize: 12,
              color: AppTheme.primaryLight,
              fontWeight: .w500,
            ),
          ),
        ),
      ],
    );
  }
}
