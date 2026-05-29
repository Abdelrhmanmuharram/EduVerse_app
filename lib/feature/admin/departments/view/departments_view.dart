import 'package:edusync_app/core/app_theme.dart';
import 'package:edusync_app/core/widgets/default_text_field.dart';
import 'package:edusync_app/core/widgets/primary_button.dart';
import 'package:edusync_app/feature/admin/departments/viewmodel/departement_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/department_model.dart';
import '../widgets/list_department_item.dart';

class DepartmentsView extends StatefulWidget {
  static const String routeName = '/departments';
  const DepartmentsView({super.key});

  @override
  State<DepartmentsView> createState() => _DepartmentsViewState();
}

class _DepartmentsViewState extends State<DepartmentsView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<DepartmentViewModel>(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Departments', style: textTheme.headlineSmall),
        centerTitle: true,
        leading: SizedBox(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DefaultTextField(
              hint: 'Search',
              prefixIcon: Icon(Icons.search, color: AppTheme.hintText),
              onChanged: viewModel.search,
            ),
            SizedBox(height: 16),
            Expanded(
              child: viewModel.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.local_fire_department,
                          size: 80,
                          color: AppTheme.primaryLight,
                        ),
                        SizedBox(height: 16),
                        Text(
                          viewModel.isEmpty
                              ? 'No Departments Yet'
                              : 'No Departments Found',
                        )
                      ],
                    )
                  : ListDepartmentItem(
                      departments: viewModel.departments,
                      onDelete: (department) async {
                        final bool? confirmDelete = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Delete Department'),
                            content: const Text(
                              'Are you sure you want to delete this department?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: Text(
                                  'Cancel',
                                  style: textTheme.titleMedium!.copyWith(
                                    color: AppTheme.primaryLight,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: Text(
                                  'Delete',
                                  style: textTheme.titleMedium!.copyWith(
                                    color: AppTheme.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                        if (confirmDelete == true) {
                            viewModel.deleteDepartment(department);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: AppTheme.red,
                              content: Text('Department deleted successfully'),
                            ),
                          );
                        }
                      },
                      onEdit: (department, index) async {
                        final result = await Navigator.pushNamed(
                          context,
                          '/edit-department',
                          arguments: department,
                        );
                        if (result != null) {
                          DepartmentModel updateDepartment =
                              result as DepartmentModel;
                            viewModel.editDepartment(index, updateDepartment);
                        }
                      },
                    ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    label: 'Back',
                    onPressed: () => Navigator.pop(context),
                    color: AppTheme.black,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  flex: 2,
                  child: PrimaryButton(
                    label: 'Add Department',
                    onPressed: () async {
                      final result = await Navigator.pushNamed(
                        context,
                        '/add-department',
                      );
                      if (!context.mounted) return;
                      if (result != null) {
                        DepartmentModel department = result as DepartmentModel;
                          viewModel.addDepartment(department);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: AppTheme.green,
                            content: Text('Department added successfully'),
                          ),
                        );
                      }
                    },
                    color: AppTheme.primaryLight,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
