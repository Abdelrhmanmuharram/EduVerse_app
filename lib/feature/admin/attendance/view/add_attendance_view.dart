import 'package:edusync_app/core/widgets/default_drop_down_field.dart';
import 'package:edusync_app/core/widgets/loading_widget.dart';
import 'package:edusync_app/core/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/widgets/back_item.dart';
import '../../../../core/widgets/title_widget.dart';
import '../../instructors/viewmodel/instructor_viewmodel.dart';
import '../view_model/attendance_view_model.dart';

class AddAttendanceView extends StatefulWidget {
  static const String routeName = '/add-attendance';
  const AddAttendanceView({super.key});

  @override
  State<AddAttendanceView> createState() => _AddAttendanceViewState();
}

class _AddAttendanceViewState extends State<AddAttendanceView> {
  @override
  Widget build(BuildContext context) {
    final instructorViewModel = context.watch<InstructorViewModel>();
    final attendanceViewModel = context.watch<AttendanceViewModel>();
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: TitleWidget(title: 'Add Attendance Session'),
            centerTitle: true,
            leading: BackItem(),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                DefaultDropDownField(
                  selectedItem: attendanceViewModel.selectedInstructorName,
                  items: instructorViewModel.instructors
                      .map((e) => e.fullName)
                      .toList(),
                  hint: 'Instructor',
                  icon: 'instructor',
                  onChanged: (value) async {
                    final instructor = instructorViewModel.instructors
                        .firstWhere((e) => e.fullName == value);
                    attendanceViewModel.selectInstructor(
                      instructorName: instructor.fullName,
                      instructorId: instructor.id,
                    );
                    attendanceViewModel.clearSubject();
                    await instructorViewModel.loadInstructorSubjects(
                      instructor.id,
                    );
                  },
                ),
                const SizedBox(height: 16),
                DefaultDropDownField(
                  selectedItem: attendanceViewModel.selectedSubjectName,
                  items: instructorViewModel.subjects
                      .map((e) => e.subject.name)
                      .toList(),
                  hint: 'Subject',
                  icon: 'subject',
                  onChanged: (value) {
                    final subject = instructorViewModel.subjects.firstWhere(
                      (e) => e.subject.name == value,
                    );
                    attendanceViewModel.selectSubject(
                      subjectName: subject.subject.name,
                      subjectId: subject.subjectId,
                    );
                  },
                ),
                const Spacer(),
                PrimaryButton(
                  label: 'Add Attendance',
                  isLoading: attendanceViewModel.isLoading,
                  onPressed: () async {
                    if (attendanceViewModel.selectedInstructorId == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please select instructor'),
                        ),
                      );
                      return;
                    }
                    if (attendanceViewModel.selectedSubjectId == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please select subject')),
                      );
                      return;
                    }
                    final result = await context
                        .read<AttendanceViewModel>()
                        .createAttendanceSession(
                          instructorId:
                              attendanceViewModel.selectedInstructorId!,
                          subjectId: attendanceViewModel.selectedSubjectId!,
                          sessionDate: DateTime.now(),
                        );
                    if (!context.mounted) return;
                    if (result) {
                      Navigator.pop(context, true);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: AppTheme.red,
                          content: Text(attendanceViewModel.errorMages),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        if (attendanceViewModel.isLoading)
          Container(
            color: Colors.black.withOpacity(0.5),
            child: const Center(child: LoadingWidget()),
          ),
      ],
    );
  }
}
