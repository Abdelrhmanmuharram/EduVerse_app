import 'package:edusync_app/core/app_theme.dart';
import 'package:edusync_app/feature/students/model/subject_attendance_model.dart';
import 'package:edusync_app/feature/students/widgets/subject_person_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../model/student_instructor_subject_model.dart';

class SubjectCardItem extends StatelessWidget {
  final String subjectName;
  final String instructorName;
  final int materialsCount;
  final double attendance;

  const SubjectCardItem({
    super.key,
    required this.subjectName,
    required this.instructorName,
    required this.materialsCount,
    required this.attendance,
  });
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: AppTheme.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: const Color(0xffF3E8FF),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.code,
                    color: Color(0xff9333EA),
                    size: 30,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subjectName,
                        style: textTheme.titleLarge?.copyWith(
                          color: AppTheme.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Lecture: 02:00 PM - 04:00 PM',
                        style: textTheme.bodyMedium?.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  size: 28,
                  color: AppTheme.secondText,
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: SubjectPersonInfo(
                    role: 'Instructor',
                    name: instructorName.isNotEmpty
                        ? 'Dr. $instructorName'
                        : 'Instructor Not Assigned',
                    image: 'assets/images/avatar.jpg',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Divider(color: AppTheme.secondText.withOpacity(.4), thickness: 1),
            const SizedBox(height: 8),
            Row(
              children: [
                SvgPicture.asset('assets/icons/mat.svg'),
                const SizedBox(width: 6),
                Text(
                  '$materialsCount Materials',
                  style: textTheme.titleMedium!.copyWith(
                    color: AppTheme.hintText,
                  ),
                ),
                const SizedBox(width: 16),
                SvgPicture.asset('assets/icons/att.svg'),
                const SizedBox(width: 4),
                Text(
                  '${attendance.toStringAsFixed(0)}% Attendance',
                  style: textTheme.titleMedium!.copyWith(
                    color: AppTheme.hintText,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
