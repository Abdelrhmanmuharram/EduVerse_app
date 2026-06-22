import 'package:edusync_app/core/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/app_theme.dart';
import '../view_model/subject_view_model.dart';

class SubjectsTable extends StatelessWidget {
  const SubjectsTable({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final viewModel = context.watch<SubjectsViewModel>();
    if (viewModel.isLoading) {
      return const Center(child: LoadingWidget());
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
          onRefresh: () => viewModel.loadSubjects(),
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
                    DataColumn(label: const Text("Code")),
                    const DataColumn(label: Text("Arabic Name")),
                    const DataColumn(label: Text("English Name")),
                    const DataColumn(label: Text("Department")),
                    const DataColumn(label: Text("Semester")),
                    const DataColumn(label: Text("Year")),
                    const DataColumn(label: Text("Actions")),
                  ],
                  rows: viewModel.filteredSubjects.map((subject) {
                    return DataRow(
                      cells: [
                        DataCell(Text(subject.code)),
                        DataCell(Text(subject.arbName)),
                        DataCell(Text(subject.engName)),
                        DataCell(Text(subject.department!.arabicName)),
                        DataCell(Text(subject.semester!.englishName)),
                        DataCell(Text(subject.year!.engName)),
                        DataCell(
                          Row(
                            children: [
                              InkWell(
                                onTap: () async {
                                  final result = await Navigator.pushNamed(
                                    context,
                                    '/subjects-details',
                                    arguments: subject,
                                  );
                                  if (result == true) {
                                    await context
                                        .read<SubjectsViewModel>()
                                        .loadSubjects();
                                    if (context.mounted) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Subject updated successfully',
                                          ),
                                          backgroundColor: AppTheme.green,
                                        ),
                                      );
                                    }
                                  }
                                },
                                child: Icon(
                                  Icons.edit,
                                  color: AppTheme.primaryLight,
                                ),
                              ),
                              SizedBox(width: 8),
                              InkWell(
                                onTap: () async {
                                  final confirm = await showDialog<bool>(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text("Delete Subject"),
                                      content: Text(
                                        "Are you sure you want to delete \n(${subject.engName} - ${subject.arbName}) ?",
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, false),
                                          child: Text(
                                            "Cancel",
                                            style: textTheme.titleSmall,
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, true),
                                          child: Text(
                                            "Delete",
                                            style: textTheme.titleSmall!
                                                .copyWith(color: AppTheme.red),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                  if (confirm == true) {
                                    try {
                                      await context
                                          .read<SubjectsViewModel>()
                                          .deleteSubject(subject.id);
                                      if (context.mounted) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Subject deleted successfully',
                                            ),
                                            backgroundColor: AppTheme.green,
                                          ),
                                        );
                                      }
                                    } catch (e) {
                                      if (context.mounted) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Unable to delete subject',
                                            ),
                                            backgroundColor: AppTheme.red,
                                          ),
                                        );
                                      }
                                    }
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
