import 'package:edusync_app/core/widgets/back_item.dart';
import 'package:edusync_app/core/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../attendance/view/scan_qr_view.dart';
import '../../materials/model/student_subject_model.dart';
import '../view_model/student_subject_details_view_model.dart';
import '../widgets/attendance_history_item.dart';
import '../widgets/course_materials_item.dart';
import '../widgets/subject_header_item.dart';

class StudentSubjectDetails extends StatefulWidget {
  static const String routeName = '/student-subject-details';
  const StudentSubjectDetails({super.key});

  @override
  State<StudentSubjectDetails> createState() => _StudentSubjectDetailsState();
}

class _StudentSubjectDetailsState extends State<StudentSubjectDetails> {
  bool _loaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_loaded) return;
    _loaded = true;
    final subject =
        ModalRoute.of(context)!.settings.arguments as StudentSubjectModel;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StudentSubjectDetailsViewModel>().loadData(subject.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final vm = context.watch<StudentSubjectDetailsViewModel>();
    if (vm.isLoading) {
      return const Scaffold(body: LoadingWidget());
    }
    if (vm.errorMessage != null) {
      return Scaffold(body: Center(child: Text(vm.errorMessage!)));
    }
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
                  Text('Course Materials', style: textTheme.headlineSmall),
                  const SizedBox(height: 16),
                  CourseMaterialsItem(),
                  const SizedBox(height: 16),
                  Text('Attendance History', style: textTheme.headlineSmall),
                  const SizedBox(height: 16),
                  AttendanceHistoryItem(),
                  const SizedBox(height: 16),
                  PrimaryButton(
                    label: 'Scan QR Code',
                    onPressed: () async {
                      final qrData = await Navigator.push<String>(
                        context,
                        MaterialPageRoute(builder: (_) => const ScanQrView()),
                      );
                      if (qrData == null) return;
                      final result = await context
                          .read<StudentSubjectDetailsViewModel>()
                          .scanAttendance(qrData: qrData);
                      if (result) {
                        await context
                            .read<StudentSubjectDetailsViewModel>()
                            .refresh();
                      }
                      if (!context.mounted) return;
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
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
