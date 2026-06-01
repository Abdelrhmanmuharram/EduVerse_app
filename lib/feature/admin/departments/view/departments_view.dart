import 'package:edusync_app/core/app_theme.dart';
import 'package:edusync_app/core/widgets/default_text_field.dart';
import 'package:edusync_app/core/widgets/empty_state_widget.dart';
import 'package:edusync_app/core/widgets/loading_widget.dart';
import 'package:edusync_app/core/widgets/primary_button.dart';
import 'package:edusync_app/core/widgets/title_widget.dart';
import 'package:edusync_app/feature/admin/departments/viewmodel/departement_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/widgets/back_item.dart';
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


  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<DepartmentViewModel>(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: TitleWidget(title: 'Departments'),
        centerTitle: true,
        leading: BackItem(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: DefaultTextField(
                    hint: 'Search',
                    prefixIcon: Icon(Icons.search, color: AppTheme.hintText),
                    onChanged: viewModel.search,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: PrimaryButton(
                    label: 'Add',
                    onPressed: () async {
                      final result = await Navigator.pushNamed(
                        context,
                        '/add-department',
                      );
                      if (!context.mounted) return;
                      if (result != null) {
                        DepartmentModel department = result as DepartmentModel;
                        await viewModel.addDepartment(department);
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
            SizedBox(height: 16),
            Expanded(
              child: viewModel.isLoading
                  ? Center(child: LoadingWidget())
                  : viewModel.isEmpty
                  ? EmptyStateWidget(
                      icon: Icons.menu_book_outlined,
                      title: 'No Departments Yet',
                      color: AppTheme.primaryLight,
                    )
                  : viewModel.departments.isEmpty
                  ? EmptyStateWidget(
                      icon: Icons.search_off_outlined,
                      title: 'No Departments Found',
                    )
                  : RefreshIndicator(
                      onRefresh: () async {
                        await viewModel.loadDepartments();
                      },
                      color: AppTheme.primaryLight,
                      backgroundColor: AppTheme.white,
                      child: ListDepartmentItem(
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
                                  onPressed: () =>
                                      Navigator.pop(context, false),
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
                            try {
                              await viewModel.deleteDepartment(department);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: AppTheme.red,
                                  content: Text(
                                    'Department deleted successfully',
                                  ),
                                ),
                              );
                            } catch (e) {
                              if (!context.mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: AppTheme.red,
                                  content: Text(e.toString()),
                                ),
                              );
                            }
                          }
                        },
                        onEdit: (department, index) async {
                          final result = await Navigator.pushNamed(
                            context,
                            '/edit-department',
                            arguments: department,
                          );
                          if (result != null) {
                            DepartmentModel updatedDepartment =
                                result as DepartmentModel;
                            await viewModel.updateDepartment(updatedDepartment);
                          }
                        },
                      ),
                    ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
