import 'package:edusync_app/core/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/app_theme.dart';
import '../../viewmodel/attendance_session_view_model.dart';
import '../../viewmodel/students_list_viewmodel.dart';
import '../screens/attendance_session_add_update_view.dart';

class InstructorTable extends StatelessWidget {
  const InstructorTable({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final viewModel = context.watch<AttendanceSessionViewModel>();
    if (viewModel.isLoading) {
      return const Center(child: LoadingWidget());
    }
    if (viewModel.sessions.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.3,
          ),
          child: Text(
            "No attendance sessions found",
            style: textTheme.headlineSmall,
          ),
        ),
      );
    }
    return Expanded(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: RefreshIndicator(
          color: AppTheme.primaryLight,
          backgroundColor: AppTheme.white,
          onRefresh: () => viewModel.loadAttendanceSessions(),
          child: ListView(
            children: [
              SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  sortAscending: true,
                  headingTextStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primaryLight,
                  ),
                  columns: [
                    DataColumn(
                      label: const Text("Subject"),
                      onSort: (_, _) => viewModel.sortBySubject(),
                    ),
                    const DataColumn(label: Text("Instructor")),
                    const DataColumn(label: Text("Code")),
                    const DataColumn(label: Text("Data")),
                    const DataColumn(label: Text("Actions")),
                  ],
                  rows: viewModel.sessions.map((session) {
                    return DataRow(
                      cells: [
                        DataCell(Text(session.subjectName)),
                        DataCell(Text(session.instructorName)),
                        DataCell(Text(session.subjectCode)),
                        DataCell(
                          Text(
                            "${session.sessionDate.day}/${session.sessionDate.month}/${session.sessionDate.year}",
                          ),
                        ),
                        DataCell(
                          Row(
                            children: [
                              InkWell(
                                onTap: () async {
                                  final vm = context
                                      .read<AttendanceSessionViewModel>();

                                  if (vm.subjects.isEmpty) {
                                    await vm.loadSubjects();
                                  }

                                  if (!context.mounted) return;

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          ChangeNotifierProvider.value(
                                            value: vm,
                                            child:
                                                AttendanceSessionAddUpdateView(
                                                  session: session,
                                                ),
                                          ),
                                    ),
                                  );
                                },
                                child: Icon(
                                  Icons.edit,
                                  color: AppTheme.primaryLight,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Icon(
                                Icons.account_box_outlined,
                                color: AppTheme.primaryLight,
                              ),
                              const SizedBox(width: 8),
                              InkWell(
                                onTap: () async {
                                  final confirm = await showDialog<bool>(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      title: const Text("Delete Session"),
                                      content: const Text(
                                        "Are you sure you want to delete this attendance session?",
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, false),
                                          child: const Text(
                                            "Cancel",
                                            style: TextStyle(
                                              color: AppTheme.secondText,
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, true),
                                          child: const Text(
                                            "Delete",
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );

                                  if (confirm != true || !context.mounted)
                                    return;

                                  try {
                                    await context
                                        .read<AttendanceSessionViewModel>()
                                        .deleteAttendanceSession(session.id);

                                    if (!context.mounted) return;

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "Attendance session deleted successfully",
                                        ),
                                        backgroundColor: AppTheme.green,
                                      ),
                                    );
                                  } catch (e) {
                                    if (!context.mounted) return;

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          e.toString().replaceFirst(
                                            "Exception: ",
                                            "",
                                          ),
                                        ),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                },
                                child: Icon(Icons.delete, color: AppTheme.red),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
