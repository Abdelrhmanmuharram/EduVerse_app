import 'package:edusync_app/core/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/services/local_storage_service.dart';
import '../../../../core/widgets/back_item.dart';
import '../../../../core/widgets/default_drop_down_field.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../admin/attendance/model/attendance_session_request_model.dart';
import '../../../admin/attendance/model/update_attendance_session_model.dart';
import '../../model/instructor_attendance_session_model.dart';
import '../../viewmodel/attendance_session_view_model.dart';

class AttendanceSessionAddUpdateView extends StatefulWidget {
  static const String routeName = '/attendance-session-add-update';

  final InstructorAttendanceSessionModel? session;

  const AttendanceSessionAddUpdateView({super.key, this.session});

  @override
  State<AttendanceSessionAddUpdateView> createState() =>
      _AttendanceSessionAddUpdateViewState();
}

class _AttendanceSessionAddUpdateViewState
    extends State<AttendanceSessionAddUpdateView> {
  int? selectedSubjectId;
  String? selectedSubjectName;

  bool get isEdit => widget.session != null;

  bool _initialized = false;

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AttendanceSessionViewModel>();
    debugPrint("Selected Subject: $selectedSubjectName");

    debugPrint(
      "Subjects: ${viewModel.subjects.map((e) => e.subject.name).toList()}",
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isEdit && !_initialized && viewModel.subjects.isNotEmpty) {
        final subject = viewModel.subjects.firstWhere(
          (e) => e.subjectId == widget.session!.subjectId,
        );
        setState(() {
          selectedSubjectId = subject.subjectId;
          selectedSubjectName = subject.subject.name;
          _initialized = true;
        });
      }
    });
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: TitleWidget(
              title: isEdit
                  ? "Edit Attendance Session"
                  : "Add Attendance Session",
            ),
            centerTitle: true,
            leading: const BackItem(),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),

            child: Column(
              children: [
                DefaultDropDownField(
                  items: viewModel.subjects.map((e) => e.subject.name).toList(),
                  selectedItem: selectedSubjectName,
                  hint: "Subject",
                  icon: "subject",
                  onChanged: (value) {
                    final subject = viewModel.subjects.firstWhere(
                      (e) => e.subject.name == value,
                    );
                    setState(() {
                      selectedSubjectName = value;
                      selectedSubjectId = subject.subjectId;
                    });
                  },
                ),
                const Spacer(),
                PrimaryButton(
                  label: isEdit ? "Update" : "Add",
                  onPressed: () async {
                    if (selectedSubjectId == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please select a subject"),
                        ),
                      );
                      return;
                    }
                    if (isEdit &&
                        selectedSubjectId == widget.session!.subjectId) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("No changes were made")),
                      );
                      return;
                    }
                    final user = await LocalStorageService.getUser();
                    if (user == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("User not found")),
                      );
                      return;
                    }
                    try {
                      if (isEdit) {
                        await viewModel.updateAttendanceSession(
                          UpdateAttendanceSessionModel(
                            id: widget.session!.id,
                            instructorId: user.id,
                            subjectId: selectedSubjectId!,
                            sessionDate: widget.session!.sessionDate,
                          ),
                        );
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.green,
                            content: Text(
                              "Attendance session updated successfully",
                            ),
                          ),
                        );
                      } else {
                        await viewModel.addAttendanceSession(
                          AttendanceSessionRequestModel(
                            instructorId: user.id,
                            subjectId: selectedSubjectId!,
                            sessionDate: DateTime.now(),
                          ),
                        );
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Attendance session added successfully",
                            ),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                      Navigator.pop(context, true);
                    } catch (e) {
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(
                            e.toString().replaceFirst("Exception: ", ""),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        if (viewModel.isLoading)
          Container(
            color: Colors.black54,
            child: const Center(child: LoadingWidget()),
          ),
      ],
    );
  }
}
