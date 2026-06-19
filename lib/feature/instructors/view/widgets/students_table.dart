import 'package:edusync_app/core/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/app_theme.dart';
import '../../viewmodel/students_list_viewmodel.dart';

class StudentsTable extends StatelessWidget {
  const StudentsTable({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final viewModel = context.watch<StudentsListViewModel>();
    if (viewModel.isLoading) {
      return const Center(child: LoadingWidget());
    }
    if (viewModel.filteredStudents.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.3,
          ),
          child: Text("No students found", style: textTheme.headlineSmall),
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
          onRefresh: () => viewModel.loadStudents(),
          child: ListView(
            children: [
              SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  sortAscending: viewModel.sortAscending,
                  headingTextStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primaryLight,
                  ),
                  columns: [
                    DataColumn(
                      label: const Text("Name"),
                      onSort: (columnIndex, ascending) =>
                          viewModel.sortStudentsByName(),
                    ),
                    const DataColumn(label: Text("Email")),
                    const DataColumn(label: Text("Status")),
                  ],
                  rows: viewModel.filteredStudents.map((student) {
                    return DataRow(
                      cells: [
                        DataCell(Text(student.fullName)),
                        DataCell(Text(student.email)),
                        DataCell(
                          Text(student.isActive ? 'Active' : 'Inactive'),
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
