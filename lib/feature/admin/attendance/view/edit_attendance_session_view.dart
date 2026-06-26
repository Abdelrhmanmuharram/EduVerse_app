import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/widgets/back_item.dart';
import '../../../../core/widgets/default_drop_down_field.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/title_widget.dart';
import '../../instructors/viewmodel/instructor_viewmodel.dart';
import '../model/attendance_session_model.dart';
import '../model/update_attendance_session_model.dart';
import '../view_model/attendance_view_model.dart';

class EditAttendanceSessionView extends StatefulWidget {
  final AttendanceSessionModel session;
  const EditAttendanceSessionView({super.key, required this.session});

  @override
  State<EditAttendanceSessionView> createState() =>
      _EditAttendanceSessionViewState();
}

class _EditAttendanceSessionViewState extends State<EditAttendanceSessionView> {
  late String originalInstructorId;
  late int originalSubjectId;

  @override
  void initState() {
    super.initState();

    originalInstructorId = widget.session.instructorId;
    originalSubjectId = widget.session.subjectId;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final instructorVM = context.read<InstructorViewModel>();
      final attendanceVM = context.read<AttendanceViewModel>();
      attendanceVM.selectInstructor(
        instructorName: widget.session.instructorName,
        instructorId: widget.session.instructorId,
      );
      await instructorVM.loadInstructorSubjects(widget.session.instructorId);
      attendanceVM.selectSubject(
        subjectName: widget.session.subjectName,
        subjectId: widget.session.subjectId,
      );
    });
  }

  bool hasChanges(AttendanceViewModel vm) {
    return vm.selectedInstructorId != originalInstructorId ||
        vm.selectedSubjectId != originalSubjectId;
  }

  @override
  Widget build(BuildContext context) {
    final instructorViewModel = context.watch<InstructorViewModel>();
    final attendanceViewModel = context.watch<AttendanceViewModel>();
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: TitleWidget(title: 'Edit Attendance Session'),
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
                  label: 'Edit Attendance',
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
                    if (!hasChanges(attendanceViewModel)) {
                      return;
                    }
                    final session = UpdateAttendanceSessionModel(
                      id: widget.session.id,
                      instructorId: attendanceViewModel.selectedInstructorId!,
                      subjectId: attendanceViewModel.selectedSubjectId!,
                      sessionDate: widget.session.sessionDate,
                    );
                    final result = await context
                        .read<AttendanceViewModel>()
                        .updateAttendanceSession(session);
                    if (!mounted) return;
                    if (result) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: AppTheme.green,
                          content: Text('Attendance updated'),
                        ),
                      );
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
