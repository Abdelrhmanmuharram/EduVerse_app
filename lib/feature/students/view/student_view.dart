import 'package:edusync_app/core/widgets/primary_button.dart';
import 'package:edusync_app/feature/students/attendance/view/scan_qr_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/app_theme.dart';
import '../view_model/student_attendance_view_model.dart';

class StudentView extends StatelessWidget {
  static const String routeName = '/student';

  const StudentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: PrimaryButton(
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
