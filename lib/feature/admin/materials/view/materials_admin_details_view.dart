import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/back_item.dart';
import '../../../../core/widgets/default_drop_down_field.dart';
import '../../../../core/widgets/default_text_field.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/title_widget.dart';
import '../../instructors/viewmodel/instructor_viewmodel.dart';
import '../../subject/view_model/subject_view_model.dart';
import '../model/materials_admin_model.dart';
import '../model/update_materials_admin_model.dart';
import '../view_model/materials_admin_view_model.dart';

class MaterialsAdminDetailsView extends StatefulWidget {
  static const String routeName = '/materials-admin-details';
  final MaterialsAdminModel material;
  const MaterialsAdminDetailsView({super.key, required this.material});

  @override
  State<MaterialsAdminDetailsView> createState() =>
      _MaterialsAdminDetailsViewState();
}

class _MaterialsAdminDetailsViewState extends State<MaterialsAdminDetailsView> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  late String originalTitle;
  late String originalDescription;
  late String originalInstructorId;
  late int originalSubjectId;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    originalTitle = widget.material.title;
    originalDescription = widget.material.description ?? '';
    originalInstructorId = widget.material.instructorId;
    originalSubjectId = widget.material.subjectId;
    titleController.text = widget.material.title;
    descriptionController.text = widget.material.description ?? '';
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vm = context.read<MaterialAdminViewModel>();
      vm.selectSubject(
        subjectName: widget.material.subject.engName,
        subjectId: widget.material.subjectId,
      );
      vm.selectInstructor(
        instructorName: widget.material.instructor.fullName,
        instructorId: widget.material.instructorId,
      );
    });
  }

  bool hasChanges(MaterialAdminViewModel viewModel) {
    return titleController.text.trim() != originalTitle ||
        descriptionController.text.trim() != originalDescription ||
        viewModel.selectedInstructorId != originalInstructorId ||
        viewModel.selectedSubjectId != originalSubjectId;
  }

  @override
  Widget build(BuildContext context) {
    final subjectsViewModel = context.watch<SubjectsViewModel>();
    final instructorsViewModel = context.watch<InstructorViewModel>();
    final materialViewModel = context.watch<MaterialAdminViewModel>();
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: TitleWidget(title: 'Edit Material'),
            centerTitle: true,
            leading: BackItem(),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  DefaultTextField(hint: 'Title', controller: titleController),
                  const SizedBox(height: 16),
                  DefaultDropDownField(
                    selectedItem: materialViewModel.selectedSubjectName,
                    items: subjectsViewModel.subjects
                        .map((e) => e.engName)
                        .toList(),
                    hint: 'Subject',
                    icon: 'department',
                    onChanged: (value) {
                      setState(() {
                        final subject = subjectsViewModel.subjects.firstWhere(
                          (e) => e.engName == value,
                        );
                        materialViewModel.selectSubject(
                          subjectName: subject.engName,
                          subjectId: subject.id,
                        );
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  DefaultDropDownField(
                    selectedItem: materialViewModel.selectedInstructorName,
                    items: instructorsViewModel.instructors
                        .map((e) => e.fullName)
                        .toList(),
                    hint: 'Instructor',
                    icon: 'profile',
                    onChanged: (value) {
                      setState(() {
                        final instructor = instructorsViewModel.instructors
                            .firstWhere((e) => e.fullName == value);
                        materialViewModel.selectInstructor(
                          instructorName: instructor.fullName,
                          instructorId: instructor.id,
                        );
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  DefaultTextField(
                    hint: 'Description',
                    controller: descriptionController,
                    validator: (value) => AppValidators.requiredField(
                      value,
                      'Please enter a description',
                    ),
                    maxLines: 5,
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: PrimaryButton(
                      label: 'Save',
                      isLoading: materialViewModel.isLoading,
                      onPressed: () async {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        if (materialViewModel.selectedSubjectId == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please select subject'),
                            ),
                          );
                          return;
                        }
                        if (materialViewModel.selectedInstructorId == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please select instructor'),
                            ),
                          );
                          return;
                        }
                        if (!hasChanges(materialViewModel)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: AppTheme.red,
                              content: Text('No changes to save'),
                            ),
                          );
                          return;
                        }
                        final material = UpdateMaterialsAdminModel(
                          id: widget.material.id,
                          instructorId: materialViewModel.selectedInstructorId!,
                          subjectId: materialViewModel.selectedSubjectId!,
                          title: titleController.text.trim(),
                          description: descriptionController.text.trim(),
                          filePath: widget.material.filePath,
                          publicId: widget.material.publicId,
                        );
                        final result = await context
                            .read<MaterialAdminViewModel>()
                            .updateMaterial(material);
                        if (!mounted) return;
                        if (result) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: AppTheme.green,
                              content: Text('Material updated successfully'),
                            ),
                          );
                          Navigator.pop(context, true);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: AppTheme.red,
                              content: Text(
                                materialViewModel.errorMessage ??
                                    'Failed to update material',
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (materialViewModel.isLoading)
          Container(
            color: Colors.black.withOpacity(0.5),
            child: const Center(child: LoadingWidget()),
          ),
      ],
    );
  }
}
