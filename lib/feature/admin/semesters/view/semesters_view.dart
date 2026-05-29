import 'package:edusync_app/core/widgets/back_item.dart';
import 'package:edusync_app/core/widgets/default_text_field.dart';
import 'package:edusync_app/core/widgets/primary_button.dart';
import 'package:edusync_app/core/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../model/semester_model.dart';
import '../viewmodel/semester_viewmodel.dart';
import '../widgets/semesters_list.dart';

class SemestersView extends StatefulWidget {
  static const String routeName = '/semesters';
  const SemestersView({super.key});

  @override
  State<SemestersView> createState() => _SemestersViewState();
}

class _SemestersViewState extends State<SemestersView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SemesterViewModel>();
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: TitleWidget(title: 'Semesters'),
        centerTitle: true,
        leading: BackItem(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: DefaultTextField(
                      onChanged: viewModel.search,
                      hint: 'Search Semesters',
                      prefixIcon: SvgPicture.asset(
                        'assets/icons/search.svg',
                        width: 24,
                        height: 24,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: PrimaryButton(
                      label: 'Add',
                      onPressed: () async {
                        final result = await Navigator.pushNamed(
                          context,
                          '/add-semester',
                        );
                        if (!context.mounted) return;
                        if (result != null) {
                          SemesterModel semester = result as SemesterModel;
                          await viewModel.addSemester(semester);
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: AppTheme.green,
                              content: Text('Semester added successfully'),
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
                        title: 'No Semesters Yet',
                      )
                    : viewModel.semesters.isEmpty
                    ? EmptyStateWidget(
                        icon: Icons.search_off_outlined,
                        title: 'No Semesters Found',
                      )
                    : RefreshIndicator(
                        color: AppTheme.primaryLight,
                        strokeWidth: 3,
                        onRefresh: viewModel.loadSemesters,
                        child: SemestersList(
                          semesters: viewModel.semesters,
                          onDelete: (semester) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  title: Text('Delete Semester'),
                                  content: Text(
                                    'Are you sure you want to delete this semester?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text(
                                        'Cancel',
                                        style: textTheme.titleMedium!.copyWith(
                                          color: AppTheme.primaryLight,
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                       await viewModel.deleteSemester(semester);
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            backgroundColor: Colors.red,
                                            content: Text(
                                              'Semester deleted successfully',
                                            ),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'Delete',
                                        style: textTheme.titleMedium!.copyWith(
                                          color: AppTheme.red,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          onEdit: (semester, index) async {
                            final result = await Navigator.pushNamed(
                              context,
                              '/edit-semester',
                              arguments: semester,
                            );
                            if (result != null) {
                              SemesterModel updateSemester =
                                  result as SemesterModel;
                              viewModel.editSemester(index, updateSemester);
                            }
                          },
                        ),
                      ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
