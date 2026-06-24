import 'dart:io';

import 'package:edusync_app/core/widgets/default_drop_down_field.dart';
import 'package:edusync_app/core/widgets/default_text_field.dart';
import 'package:edusync_app/core/widgets/loading_widget.dart';
import 'package:edusync_app/core/widgets/primary_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/widgets/back_item.dart';
import '../../../../core/widgets/title_widget.dart';
import '../../instructors/viewmodel/instructor_viewmodel.dart';
import '../../subject/view_model/subject_view_model.dart';
import '../view_model/materials_admin_view_model.dart';

class AddMaterialsAdminView extends StatefulWidget {
  static const String routeName = '/add-materials-admin';
  const AddMaterialsAdminView({super.key});

  @override
  State<AddMaterialsAdminView> createState() => _AddMaterialsAdminViewState();
}

class _AddMaterialsAdminViewState extends State<AddMaterialsAdminView> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
            title: TitleWidget(title: 'Add Material'),
            centerTitle: true,
            leading: BackItem(),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  DefaultTextField(
                    hint: 'Title',
                    controller: titleController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
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
                  ),
                  const SizedBox(height: 16),
                  PrimaryButton(
                    label:
                        materialViewModel.selectedPdfName ?? 'Select PDF File',
                    onPressed: materialViewModel.pickPdf,
                    icon: Icons.upload_file,
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
                        if (materialViewModel.selectedPdf == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please select PDF file'),
                            ),
                          );
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
                        final result = await context
                            .read<MaterialAdminViewModel>()
                            .createMaterial(
                              pdfFile: materialViewModel.selectedPdf,
                              instructorId:
                                  materialViewModel.selectedInstructorId,
                              subjectId: materialViewModel.selectedSubjectId,
                              title: titleController.text,
                              description: descriptionController.text,
                            );
                        if (!mounted) return;
                        if (result) {
                          Navigator.pop(context, true);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                materialViewModel.errorMessage ??
                                    'Failed to add material',
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
