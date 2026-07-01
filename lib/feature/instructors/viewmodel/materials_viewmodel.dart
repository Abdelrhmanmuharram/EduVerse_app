import 'dart:io';

import 'package:dio/dio.dart';
import 'package:edusync_app/core/services/local_storage_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';

import '../../admin/instructors/model/instructor_subject_model.dart';
import '../../admin/instructors/repository/instructor_subject_repository.dart';
import '../model/instructor_material_model.dart';
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

  List<InstructorMaterialModel> _instructorMaterials = [];
  List<InstructorMaterialModel> get instructorMaterials => _instructorMaterials;

  List<InstructorMaterialModel> _filteredMaterials = [];
  List<InstructorMaterialModel> get filteredMaterials => _filteredMaterials;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  void search(String value) {
    if (value.trim().isEmpty) {
      _filteredMaterials = List.from(_instructorMaterials);
    } else {
      final q = value.toLowerCase();

      _filteredMaterials = _instructorMaterials.where((e) {
        return e.title.toLowerCase().contains(q) ||
            e.subjectName.toLowerCase().contains(q);
      }).toList();
    }

    notifyListeners();
  }

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
      print(e);
    }
  }

  Future<void> loadMaterials() async {
    try {
      isLoading = true;
      _errorMessage = null;
      notifyListeners();
      final user = await LocalStorageService.getUser();
      if (user == null) {
        throw Exception("User not found");
      }
      _instructorMaterials = await _materialsRepository.getInstructorMaterials(
        user.id,
      );
      _filteredMaterials = List.from(_instructorMaterials);
    } on DioException catch (e) {
      _errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteMaterial(int materialId) async {
    try {
      isLoading = true;
      notifyListeners();
      await _materialsRepository.deleteMaterial(materialId);
      _instructorMaterials.removeWhere((e) => e.id == materialId);
      _filteredMaterials.removeWhere((e) => e.id == materialId);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
