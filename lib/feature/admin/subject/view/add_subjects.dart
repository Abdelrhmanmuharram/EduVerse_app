import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/widgets/back_item.dart';
import '../../../../core/widgets/default_drop_down_field.dart';
import '../../../../core/widgets/default_text_field.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/title_widget.dart';
import '../../../years/viewmodel/year_viewmodel.dart';
import '../../departments/viewmodel/departement_viewmodel.dart';
import '../../semesters/viewmodel/semester_viewmodel.dart';
import '../model/subjects_model.dart';
import '../view_model/subject_view_model.dart';

class AddSubjects extends StatefulWidget {
  static const routeName = '/add-subjects';
  const AddSubjects({super.key});

  @override
  State<AddSubjects> createState() => _AddSubjectsState();
}

class _AddSubjectsState extends State<AddSubjects> {
  final codeController = TextEditingController();
  final arabicNameController = TextEditingController();
  final englishNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? selectedDepartmentName;
  int? selectedDepartmentId;
  String? selectedSemesterName;
  int? selectedSemesterId;
  String? selectedYearName;
  int? selectedYearId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final code = await context.read<SubjectsViewModel>().getNextCode();
      codeController.text = code;
    });
  }

  @override
  void dispose() {
    codeController.dispose();
    arabicNameController.dispose();
    englishNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final departmentViewModel = context.watch<DepartmentViewModel>();
    final semesterViewModel = context.watch<SemesterViewModel>();
    final yearViewModel = context.watch<YearViewmodel>();
    final viewModel = context.watch<SubjectsViewModel>();
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: TitleWidget(title: 'Subjects Details'),
            centerTitle: true,
            leading: BackItem(),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: DefaultTextField(
                          hint: 'Code',
                          controller: codeController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Code is required';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: PrimaryButton(
                          label: 'Generate',
                          onPressed: () async {
                            try {
                              final code = await context
                                  .read<SubjectsViewModel>()
                                  .getNextCode();

                              codeController.text = code;
                            } catch (e) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Failed to generate code'),
                                    backgroundColor: AppTheme.red,
                                  ),
                                );
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  DefaultTextField(
                    hint: 'Arabic Name',
                    controller: arabicNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Arabic name is required';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 16),
                  DefaultTextField(
                    hint: 'English Name',
                    controller: englishNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'English name is required';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 16),
                  DefaultDropDownField(
                    items: departmentViewModel.departments
                        .map((e) => e.englishName)
                        .toList(),
                    selectedItem: selectedDepartmentName,
                    onChanged: (value) {
                      setState(() {
                        selectedDepartmentName = value;
                        selectedDepartmentId = departmentViewModel.departments
                            .firstWhere((e) => e.englishName == value)
                            .id;
                      });
                    },
                    hint: 'Select Department',
                    icon: 'department',
                  ),
                  const SizedBox(height: 16),
                  DefaultDropDownField(
                    items: semesterViewModel.semesters
                        .map((e) => e.englishName)
                        .toList(),
                    selectedItem: selectedSemesterName,
                    onChanged: (value) {
                      setState(() {
                        selectedSemesterName = value;
                        selectedSemesterId = semesterViewModel.semesters
                            .firstWhere((e) => e.englishName == value)
                            .id;
                      });
                    },
                    hint: 'Select Semester',
                    icon: 'department',
                  ),
                  const SizedBox(height: 16),
                  DefaultDropDownField(
                    items: yearViewModel.years.map((e) => e.engName).toList(),
                    selectedItem: selectedYearName,
                    onChanged: (value) {
                      setState(() {
                        selectedYearName = value;
                        selectedYearId = yearViewModel.years
                            .firstWhere((e) => e.engName == value)
                            .id;
                      });
                    },
                    hint: 'Select Year',
                    icon: 'year',
                  ),
                  const Spacer(),
                  PrimaryButton(
                    label: viewModel.isLoading ? 'Saving...' : 'Save',
                    onPressed: () async {
                      if (!formKey.currentState!.validate()) {
                        return;
                      }

                      if (selectedDepartmentId == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: AppTheme.red,
                            content: Text('Please select department'),
                          ),
                        );
                        return;
                      }
                      if (selectedSemesterId == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: AppTheme.red,
                            content: Text('Please select semester'),
                          ),
                        );
                        return;
                      }
                      if (selectedYearId == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: AppTheme.red,
                            content: Text('Please select year'),
                          ),
                        );
                        return;
                      }
                      final subject = SubjectsModel(
                        id: 0,
                        code: codeController.text.trim(),
                        arbName: arabicNameController.text.trim(),
                        engName: englishNameController.text.trim(),
                        departmentId: selectedDepartmentId!,
                        semesterId: selectedSemesterId!,
                        yearId: selectedYearId!,
                      );
                      await context.read<SubjectsViewModel>().addSubject(
                        subject,
                      );
                      if (context.mounted) {
                        Navigator.pop(context, true);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        if (viewModel.isLoading)
          Container(
            color: AppTheme.black.withAlpha(100),
            child: Center(child: LoadingWidget()),
          ),
      ],
    );
  }
}
