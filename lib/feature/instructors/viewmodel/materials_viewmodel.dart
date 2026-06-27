import 'dart:io';

import 'package:edusync_app/core/services/local_storage_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';

import '../../admin/instructors/model/instructor_subject_model.dart';
import '../../admin/instructors/repository/instructor_subject_repository.dart';
import '../model/materials_model.dart';
import '../repository/materials_repository.dart';

class MaterialsViewModel extends ChangeNotifier {
  final MaterialsRepository _materialsRepository;
  final InstructorSubjectRepository _instructorSubjectRepository;
  MaterialsViewModel(
    this._materialsRepository,
    this._instructorSubjectRepository,
  );
  bool isLoading = false;
  File? selectedFile;
  List<InstructorSubjectModel> subjects = [];

  Future<void> addMaterial(MaterialsModel material) async {
    try {
      isLoading = true;
      notifyListeners();
      await _materialsRepository.addMaterial(material);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      selectedFile = File(result.files.single.path!);
      notifyListeners();
    }
  }

  void selectFile(File file) {
    selectedFile = file;
    notifyListeners();
  }

  void removeFile() {
    selectedFile = null;
    notifyListeners();
  }

  final List materials = [
    {"name": "Syllabus_2024.pdf", "info": "1.2 MB • Oct 13"},
    {"name": "Lecture_Notes_W1.pptx", "info": "4.5 MB • Oct 14"},
    {"name": "Assignment_Guide.docx", "info": "0.8 MB • Oct 15"},
  ];

  Future<void> loadSubjects() async {
    try {
      final user = await LocalStorageService.getUser();
      final response = await _instructorSubjectRepository.getInstructorSubjects(
        user!.id,
      );
      subjects = response;
      notifyListeners();
    } catch (e) {
    }
  }
}
