import 'package:edusync_app/core/widgets/back_item.dart';
import 'package:edusync_app/core/widgets/title_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/app_theme.dart';
import '../../../core/widgets/primary_button.dart';
import '../attendance/view/scan_qr_view.dart';
import '../attendance/view_model/student_attendance_view_model.dart';
import '../widgets/attendance_history_item.dart';
import '../widgets/course_materials_item.dart';
import '../widgets/subject_header_item.dart';

class StudentSubjectDetails extends StatelessWidget {
  static const String routeName = '/student-subject-details';
  const StudentSubjectDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final subjectId = ModalRoute.of(context)!.settings.arguments as int;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: TitleWidget(title: 'Subject Details'),
        centerTitle: true,
        leading: BackItem(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SubjectHeaderItem(),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Course Materials',
                        style: textTheme.headlineSmall,
                      ),
                      Spacer(),
                      Text(
                        'View All',
                        style: textTheme.titleSmall!.copyWith(
                          color: AppTheme.primaryLight,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  CourseMaterialsItem(),
                  const SizedBox(height: 16),
                  Text('Attendance History', style: textTheme.headlineSmall),
                  const SizedBox(height: 16),
                  AttendanceHistoryItem()
                  ,const SizedBox(height: 16),
                  PrimaryButton(
                    label: 'Scan QR Code',
                    onPressed: () async {
                      final qrData = await Navigator.push<String>(
                        context,
                        MaterialPageRoute(builder: (_) => const ScanQrView()),
                      );
                      if (qrData == null) return;
                      final result = await context
                          .read<StudentAttendanceViewModel>()
                          .scanAttendance(qrData: qrData);
                      if (!context.mounted) return;
                      final vm = context.read<StudentAttendanceViewModel>();
                      if (result) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: AppTheme.green,
                            content: Text('Attendance recorded successfully'),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              vm.errorMessage ?? 'Something went wrong',
                            ),
                          ),
                        );
                      }
                    },
                  )
                  ,const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
