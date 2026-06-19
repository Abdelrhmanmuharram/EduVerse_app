import 'package:edusync_app/core/widgets/default_drop_down_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/widgets/back_item.dart';
import '../../../../core/widgets/default_text_field.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/title_widget.dart';
import '../../viewmodel/materials_viewmodel.dart';
import '../widgets/upload_item.dart';

class MaterialAddView extends StatefulWidget {
  static const String routeName = '/material-add';
  const MaterialAddView({super.key});

  @override
  State<MaterialAddView> createState() => _MaterialAddViewState();
}

class _MaterialAddViewState extends State<MaterialAddView> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  String? selectedSubjectName;
  int? selectedSubjectId;
  bool selected = false;

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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: TitleWidget(title: 'Add Material'),
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
            Text("Subjects Count: ${viewModel.subjects.length}"),
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
                debugPrint(selectedSubjectId.toString());
                debugPrint(selectedSubjectName.toString());
              },
            ),
            const SizedBox(height: 16),

            DefaultTextField(
              controller: descriptionController,
              maxLines: 4,
              hint: 'Write material description here...',
            ),
            const SizedBox(height: 16),
            InkWell(
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
            const SizedBox(height: 16),
            if (viewModel.selectedFile != null)
              UploadItem(
                file: viewModel.selectedFile!,
                onDelete: () {
                  viewModel.removeFile();
                },
              ),
            Spacer(),
            PrimaryButton(label: 'Add Material', onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
