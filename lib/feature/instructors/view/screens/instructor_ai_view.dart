import 'dart:io';

import 'package:dio/dio.dart';
import 'package:edusync_app/core/widgets/back_item.dart';
import 'package:edusync_app/core/widgets/default_drop_down_field.dart';
import 'package:edusync_app/core/widgets/default_text_field.dart';
import 'package:edusync_app/core/widgets/primary_button.dart';
import 'package:edusync_app/core/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '../../model/generate_ai_model.dart';
import '../../viewmodel/attendance_session_view_model.dart';
import '../widgets/instructor_chat_context_card.dart';

class InstructorAiView extends StatefulWidget {
  static const String routeName = '/instructor-ai';
  const InstructorAiView({super.key});

  @override
  State<InstructorAiView> createState() => _InstructorAiViewState();
}

class _InstructorAiViewState extends State<InstructorAiView> {
  bool isGenerating = false;
  int? selectedType;
  int? selectedFormat;
  int? selectedDifficulty;
  TextEditingController numberOfMCQController = TextEditingController();
  TextEditingController numberOfEasyController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AttendanceSessionViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: TitleWidget(title: 'AI Exam Generator'),
        centerTitle: true,
        leading: BackItem(),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                AIContextCard(),
                const SizedBox(height: 10),
                DefaultDropDownField(
                  items: const ['Quiz', 'Summary'],
                  selectedItem: selectedType == null
                      ? null
                      : selectedType == 1
                      ? 'Quiz'
                      : 'Summary',
                  hint: 'What do you want to generate?',
                  onChanged: (value) {
                    setState(() {
                      selectedType = value == 'Quiz' ? 1 : 2;
                    });
                  },
                ),
                const SizedBox(height: 10),
                DefaultDropDownField(
                  items: const ['Word Doc', 'PDF'],
                  selectedItem: selectedFormat == null
                      ? null
                      : selectedFormat == 1
                      ? 'Word Doc'
                      : 'PDF',
                  hint: 'Export As',
                  onChanged: (value) {
                    setState(() {
                      selectedFormat = value == 'Word Doc' ? 1 : 2;
                    });
                  },
                ),
                const SizedBox(height: 10),
                DefaultDropDownField(
                  items: const ['Easy', 'Medium', 'Hard'],
                  selectedItem: selectedDifficulty == null
                      ? null
                      : selectedDifficulty == 1
                      ? 'Easy'
                      : selectedDifficulty == 2
                      ? 'Medium'
                      : 'Hard',
                  hint: 'Difficulty',
                  onChanged: (value) {
                    setState(() {
                      switch (value) {
                        case 'Easy':
                          selectedDifficulty = 1;
                          break;
                        case 'Medium':
                          selectedDifficulty = 2;
                          break;
                        case 'Hard':
                          selectedDifficulty = 3;
                          break;
                      }
                    });
                  },
                ),
                const SizedBox(height: 10),
                DefaultTextField(
                  textInputAction: TextInputAction.next,
                  hint: 'Number of MCQs',
                  controller: numberOfMCQController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a number';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                DefaultTextField(
                  textInputAction: TextInputAction.done,
                  hint: 'Number of Essay Questions',
                  controller: numberOfEasyController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a number';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                PrimaryButton(
                  isLoading: isGenerating,
                  label: 'Generate & Download',
                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }

                    if (selectedType == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please select generation type"),
                        ),
                      );
                      return;
                    }

                    if (selectedFormat == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please select export format"),
                        ),
                      );
                      return;
                    }

                    if (selectedDifficulty == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please select difficulty"),
                        ),
                      );
                      return;
                    }
                    if (viewModel.selectedMaterials.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please select at least one material"),
                        ),
                      );
                      return;
                    }
                    final vm = context.read<AttendanceSessionViewModel>();
                    if (selectedType == null ||
                        selectedFormat == null ||
                        selectedDifficulty == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please fill all fields")),
                      );
                      return;
                    }
                    if (vm.selectedMaterials.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please select at least one material"),
                        ),
                      );
                      return;
                    }
                    setState(() {
                      isGenerating = true;
                    });
                    try {
                      final bytes = await vm.generateAI(
                        GenerateAIModel(
                          format: selectedFormat!,
                          materialIds: vm.selectedMaterials
                              .map((e) => e.id)
                              .toList(),
                          type: selectedType!,
                          difficulty: selectedDifficulty!,
                          mcqCount: int.parse(numberOfMCQController.text),
                          essayCount: int.parse(numberOfEasyController.text),
                        ),
                      );
                      final dir = await getApplicationDocumentsDirectory();
                      final extension = selectedFormat == 1 ? "docx" : "pdf";
                      final file = File(
                        "${dir.path}/AI_Generated_${DateTime.now().millisecondsSinceEpoch}.$extension",
                      );
                      await file.writeAsBytes(bytes);
                      await OpenFilex.open(file.path);
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Generated successfully"),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } on DioException catch (e) {
                      String message;
                      switch (e.type) {
                        case DioExceptionType.connectionTimeout:
                        case DioExceptionType.sendTimeout:
                        case DioExceptionType.receiveTimeout:
                          message =
                              "The AI is taking longer than expected. Please wait a moment and try again.";
                          break;
                        case DioExceptionType.connectionError:
                          message =
                              "No internet connection. Please check your network and try again.";
                          break;
                        case DioExceptionType.badResponse:
                          message =
                              e.response?.data["message"] ??
                              "Something went wrong while generating your file.";
                          break;
                        default:
                          message =
                              "An unexpected error occurred. Please try again.";
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(message),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } finally {
                      setState(() {
                        isGenerating = false;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
