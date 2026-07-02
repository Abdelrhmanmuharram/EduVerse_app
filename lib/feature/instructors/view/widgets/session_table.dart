import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../viewmodel/attendance_session_view_model.dart';

class SessionTable extends StatefulWidget {
  final String sessionId;
  const SessionTable({super.key, required this.sessionId});

  @override
  State<SessionTable> createState() => _SessionTableState();
}

class _SessionTableState extends State<SessionTable> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AttendanceSessionViewModel>().loadSessionAttendances(
        widget.sessionId,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final viewModel = context.watch<AttendanceSessionViewModel>();
    if (viewModel.isLoading) {
      return const Center(child: LoadingWidget());
    }
    if (viewModel.filteredAttendances.isEmpty) {
      return const Center(
        child: Text("No students found"),
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
          onRefresh: () => viewModel.loadSessionAttendances(widget.sessionId),
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
                    const DataColumn(label: Text("Name")),
                    const DataColumn(label: Text("Attendance Date")),
                    const DataColumn(label: Text("Status")),
                  ],
                  rows: viewModel.filteredAttendances.map((attendance) {
                    return DataRow(
                      cells: [
                        DataCell(Text(attendance.studentName)),
                        DataCell(
                          Text(
                            "${attendance.attendanceTime.day}/${attendance.attendanceTime.month}/${attendance.attendanceTime.year}",
                          ),
                        ),
                        DataCell(
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: attendance.isPresent
                                  ? Colors.green.withOpacity(.15)
                                  : Colors.red.withOpacity(.15),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              attendance.isPresent ? "Present" : "Absent",
                              style: TextStyle(
                                color: attendance.isPresent
                                    ? Colors.green
                                    : Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
