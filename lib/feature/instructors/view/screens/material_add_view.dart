import 'package:edusync_app/core/widgets/default_drop_down_field.dart';
import 'package:edusync_app/core/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/services/local_storage_service.dart';
import '../../../../core/widgets/back_item.dart';
import '../../../../core/widgets/default_text_field.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/title_widget.dart';
import '../../model/instructor_material_model.dart';
import '../../model/materials_model.dart';
import '../../model/update_material_model.dart';
import '../../viewmodel/materials_viewmodel.dart';
import '../widgets/upload_item.dart';

class MaterialAddView extends StatefulWidget {
  static const String routeName = '/material-add';
  final InstructorMaterialModel? material;
  const MaterialAddView({super.key, this.material});

  @override
  State<MaterialAddView> createState() => _MaterialAddViewState();
}

class _MaterialAddViewState extends State<MaterialAddView> {
  bool get isEdit => widget.material != null;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  String? selectedSubjectName;
  int? selectedSubjectId;
  bool selected = false;

  @override
  void initState() {
    super.initState();
    if (isEdit) {
      titleController.text = widget.material!.title;
      descriptionController.text = widget.material!.description ?? "";
      selectedSubjectId = widget.material!.subjectId;
      selectedSubjectName = widget.material!.subjectName;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final viewModel = context.watch<MaterialsViewModel>();
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: TitleWidget(
              title: isEdit ? 'Edit Material' : 'Add Material',
            ),
            centerTitle: true,
            leading: BackItem(),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text("Material Information", style: textTheme.titleMedium),
                const SizedBox(height: 6),
                DefaultTextField(
                  controller: titleController,
                  hint: 'Title',
                  prefixIcon: Icon(Icons.title, color: AppTheme.hintText),
                ),
                const SizedBox(height: 16),
                DefaultDropDownField(
                  items: viewModel.subjects.map((e) => e.subject.name).toList(),
                  selectedItem: selectedSubjectName,
                  hint: 'Subject',
                  icon: 'subject',
                  onChanged: (value) {
                    final selectedSubject = viewModel.subjects.firstWhere(
                      (e) => e.subject.name == value,
                    );
                    setState(() {
                      selectedSubjectName = value;
                      selectedSubjectId = selectedSubject.subjectId;
                    });
                  },
                ),
                const SizedBox(height: 16),

                DefaultTextField(
                  controller: descriptionController,
                  maxLines: 4,
                  hint: 'Write material description here...',
                ),
                const SizedBox(height: 16),
                Visibility(
                  visible: !isEdit,
                  child: InkWell(
                    onTap: () async {
                      await context.read<MaterialsViewModel>().pickFile();
                    },
                    child: Container(
                      width: double.infinity,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppTheme.secondText.withOpacity(0.4),
                          width: 1.5,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.cloud_upload_outlined,
                            color: AppTheme.primaryLight,
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Upload PDF",
                            style: textTheme.bodyMedium!.copyWith(
                              color: AppTheme.primaryLight,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Max size 10 MB",
                            style: textTheme.bodySmall!.copyWith(
                              color: AppTheme.hintText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                if (viewModel.selectedFile != null)
                  UploadItem(
                    file: viewModel.selectedFile!,
                    onDelete: () {
                      viewModel.removeFile();
                    },
                  ),
                Spacer(),
                PrimaryButton(
                  label: isEdit ? 'Update Material' : 'Add Material',
                  onPressed: () async {
                    if (titleController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please enter a title")),
                      );
                      return;
                    }
                    if (selectedSubjectId == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please select a subject"),
                        ),
                      );
                      return;
                    }
                    if (!isEdit && viewModel.selectedFile == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please upload a PDF")),
                      );
                      return;
                    }
                    final user = await LocalStorageService.getUser();
                    if (user == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("User not found")),
                      );
                      return;
                    }
                    if (isEdit) {
                      final hasChanged =
                          titleController.text.trim() !=
                              widget.material!.title ||
                          descriptionController.text.trim() !=
                              (widget.material!.description ?? "") ||
                          selectedSubjectId != widget.material!.subjectId;
                      if (!hasChanged) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("No changes were made")),
                        );
                        return;
                      }
                      await viewModel.updateMaterial(
                        UpdateMaterialModel(
                          id: widget.material!.id,
                          instructorId: user.id,
                          subjectId: selectedSubjectId!,
                          title: titleController.text.trim(),
                          description: descriptionController.text.trim(),
                          filePath: widget.material!.filePath,
                          publicId: widget.material!.publicId,
                        ),
                      );
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Material updated successfully"),
                          backgroundColor: AppTheme.green,
                        ),
                      );
                    } else {
                      await viewModel.addMaterial(
                        MaterialsModel(
                          title: titleController.text.trim(),
                          description: descriptionController.text.trim(),
                          file: viewModel.selectedFile!,
                          instructorId: user.id,
                          subjectId: selectedSubjectId!,
                        ),
                      );
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Material added successfully"),
                          backgroundColor: AppTheme.green,
                        ),
                      );
                    }
                    Navigator.pop(context, true);
                  },
                ),
              ],
            ),
          ),
        ),
        if (viewModel.isLoading)
          Container(
            color: AppTheme.black.withOpacity(0.5),
            child: Center(child: LoadingWidget()),
          ),
      ],
    );
  }
}
