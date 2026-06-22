import 'package:edusync_app/core/widgets/default_drop_down_field.dart';
import 'package:edusync_app/core/widgets/default_text_field.dart';
import 'package:edusync_app/core/widgets/loading_widget.dart';
import 'package:edusync_app/core/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/widgets/back_item.dart';
import '../../../../core/widgets/title_widget.dart';
import '../../../years/viewmodel/year_viewmodel.dart';
import '../../departments/viewmodel/departement_viewmodel.dart';
import '../../semesters/viewmodel/semester_viewmodel.dart';
import '../model/subjects_model.dart';
import '../view_model/subject_view_model.dart';

class SubjectsDetails extends StatefulWidget {
  static const routeName = '/subjects-details';
  const SubjectsDetails({super.key});

  @override
  State<SubjectsDetails> createState() => _SubjectsDetailsState();
}

class _SubjectsDetailsState extends State<SubjectsDetails> {
  final codeController = TextEditingController();
  final arabicNameController = TextEditingController();
  final englishNameController = TextEditingController();
  String? selectedDepartmentName;
  int? selectedDepartmentId;
  String? selectedSemesterName;
  int? selectedSemesterId;
  String? selectedYearName;
  int? selectedYearId;
  late SubjectsModel subject;
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    if (!_isInitialized) {
      subject = ModalRoute.of(context)!.settings.arguments as SubjectsModel;
      codeController.text = subject.code;
      arabicNameController.text = subject.arbName;
      englishNameController.text = subject.engName;
      _isInitialized = true;
      selectedDepartmentId = subject.departmentId;
      selectedSemesterId = subject.semesterId;
      selectedYearId = subject.yearId;
      selectedDepartmentName = subject.department?.englishName;
      selectedSemesterName = subject.semester?.englishName;
      selectedYearName = subject.year?.engName;
    }
    super.didChangeDependencies();
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
            child: Column(
              children: [
                DefaultTextField(hint: 'Code', controller: codeController),
                const SizedBox(height: 16),
                DefaultTextField(
                  hint: 'Arabic Name',
                  controller: arabicNameController,
                ),
                const SizedBox(height: 16),
                DefaultTextField(
                  hint: 'English Name',
                  controller: englishNameController,
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
                  hint: 'Select Semester',
                  icon: 'year',
                ),
                const Spacer(),
                PrimaryButton(
                  label: 'Save',
                  onPressed: () async {
                    final updatedSubject = SubjectsModel(
                      id: subject.id,
                      code: codeController.text.trim(),
                      arbName: arabicNameController.text.trim(),
                      engName: englishNameController.text.trim(),
                      departmentId: selectedDepartmentId!,
                      semesterId: selectedSemesterId!,
                      yearId: selectedYearId!,
                      department: subject.department,
                      semester: subject.semester,
                      year: subject.year,
                    );
                    final hasChanges =
                        updatedSubject.code != subject.code ||
                        updatedSubject.arbName != subject.arbName ||
                        updatedSubject.engName != subject.engName ||
                        updatedSubject.departmentId != subject.departmentId ||
                        updatedSubject.semesterId != subject.semesterId ||
                        updatedSubject.yearId != subject.yearId;
                    if (!hasChanges) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('No changes detected')),
                      );
                      return;
                    }
                    await context.read<SubjectsViewModel>().updateSubject(
                      subject.id,
                      updatedSubject,
                    );
                    Navigator.pop(context, true);
                  },
                ),
              ],
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
