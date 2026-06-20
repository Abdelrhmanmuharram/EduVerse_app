import 'package:edusync_app/core/app_theme.dart';
import 'package:edusync_app/core/widgets/default_text_field.dart';
import 'package:edusync_app/core/widgets/loading_widget.dart';
import 'package:edusync_app/core/widgets/primary_button.dart';
import 'package:edusync_app/feature/admin/years/view/years_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/widgets/back_item.dart';
import '../../../../core/widgets/title_widget.dart';
import '../../../years/viewmodel/year_viewmodel.dart';
import '../widgets/list_year_item.dart';
import 'add_years_view.dart';

class YearsView extends StatelessWidget {
  static const String routeName = '/years';
  const YearsView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<YearViewmodel>(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: TitleWidget(title: 'Years'),
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
                        onChanged: (value) {
                          viewModel.searchYears(value);
                        },
                        hint: 'Search',
                        prefixIcon: SvgPicture.asset(
                          'assets/icons/search.svg',
                          width: 24,
                          height: 24,
                          fit: .scaleDown,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: PrimaryButton(
                        label: 'Add',
                        onPressed: () async {
                          final result = await Navigator.pushNamed(
                            context,
                            AddYearsView.routeName,
                          );
                          if (result == true) {
                            context.read<YearViewmodel>().loadYears();
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: RefreshIndicator(
                    color: AppTheme.primaryLight,
                    backgroundColor: AppTheme.white,
                    onRefresh: () async {
                      await viewModel.loadYears();
                    },
                    child: viewModel.filteredYears.isEmpty
                        ? Center(child: Text('No years found',style: textTheme.headlineSmall))
                        : ListYearItem(
                            year: viewModel.filteredYears,
                            onDelete: (year) async {
                              final confirm = await showDialog<bool>(
                                context: context,
                                builder: (context) => AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  title: const Text("Delete Year"),
                                  content: Text(
                                    "You are sure you want to Delete (${year.engName}) ?",
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
                                        style: textTheme.titleSmall!.copyWith(
                                          color: AppTheme.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                              if (confirm == true) {
                                await viewModel.deleteYears(year.id);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: AppTheme.green,
                                    content: Text("Year deleted successfully"),
                                  ),
                                );
                              }
                            },
                            onEdit: (year, index) async {
                              final result = await Navigator.pushNamed(
                                context,
                                YearsDetailsView.routeName,
                                arguments: year,
                              );
                              if (result == true) {
                                await context.read<YearViewmodel>().loadYears();
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Year updated successfully',
                                      ),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                }
                              }
                            },
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (viewModel.isLoading)
          Container(
            color: Colors.black.withValues(alpha: 0.4),
            child: const Center(child: LoadingWidget()),
          ),
      ],
    );
  }
}
