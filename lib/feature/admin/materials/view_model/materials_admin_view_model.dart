import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/services/pdf_cache_service.dart';
import '../../instructors/repository/instructor_subject_repository.dart';
import '../model/materials_admin_model.dart';
import '../model/materials_request_model.dart';
import '../model/update_materials_admin_model.dart';
import '../repository/materials_admin_repository.dart';

class MaterialAdminViewModel extends ChangeNotifier {
  final MaterialsAdminRepository _repository;
  final InstructorSubjectRepository _instructorRepository;

  MaterialAdminViewModel(this._repository, this._instructorRepository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isDownloading = false;
  bool get isDownloading => _isDownloading;
  List<MaterialsAdminModel> _filteredMaterials = [];
  List<MaterialsAdminModel> _materials = [];
  List<MaterialsAdminModel> get materials =>
      _filteredMaterials.isEmpty ? _materials : _filteredMaterials;
  File? _selectedPdf;
  File? get selectedPdf => _selectedPdf;
  String? _selectedPdfName;
  String? get selectedPdfName => _selectedPdfName;
  String? _selectedInstructorName;
  String? get selectedInstructorName => _selectedInstructorName;
  String? _selectedInstructorId;
  String? get selectedInstructorId => _selectedInstructorId;
  String? _selectedSubjectName;
  String? get selectedSubjectName => _selectedSubjectName;
  int? _selectedSubjectId;
  int? get selectedSubjectId => _selectedSubjectId;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  void searchMaterials(String query) {
    if (query.trim().isEmpty) {
      _filteredMaterials = [];
    } else {
      _filteredMaterials = _materials.where((material) {
        return material.title.toLowerCase().contains(query.toLowerCase()) ||
            material.subject.engName.toLowerCase().contains(
              query.toLowerCase(),
            ) ||
            material.instructor.fullName.toLowerCase().contains(
              query.toLowerCase(),
            );
      }).toList();
    }
    notifyListeners();
  }

  Future<void> loadMaterials() async {
    try {
      _isLoading = true;
      notifyListeners();
      _materials = await _repository.getMaterials();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> downloadPdf(String url, String fileName) async {
    try {
      _isDownloading = true;
      notifyListeners();
      return await PdfCacheService.downloadPdf(url, fileName);
    } finally {
      _isDownloading = false;
      notifyListeners();
    }
  }

  Future<bool> addMaterial(MaterialRequestModel material) async {
    try {
      _isLoading = true;
      notifyListeners();
      final result = await _repository.addMaterials(material);
      if (result) {
        await loadMaterials();
      }
      return result;
    } catch (e) {
      if (e is DioException) {
        _errorMessage = e.response?.data['message'] ?? 'Server Error';
      } else {
        _errorMessage = e.toString();
      }
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createMaterial({
    required File? pdfFile,
    required String? instructorId,
    required int? subjectId,
    required String title,
    required String description,
  }) async {
    final material = MaterialRequestModel(
      file: pdfFile!,
      instructorId: instructorId!,
      subjectId: subjectId!,
      title: title.trim(),
      description: description.trim(),
    );
    return await addMaterial(material);
  }

  Future<void> pickPdf() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      _selectedPdf = File(result.files.single.path!);
      _selectedPdfName = result.files.single.name;
      notifyListeners();
    }
  }

  void selectSubject({required String subjectName, required int subjectId}) {
    _selectedSubjectName = subjectName;
    _selectedSubjectId = subjectId;
    notifyListeners();
  }

  void selectInstructor({
    required String instructorName,
    required String instructorId,
  }) {
    _selectedInstructorName = instructorName;
    _selectedInstructorId = instructorId;
    notifyListeners();
  }

  Future<bool> deleteMaterial(int id) async {
    try {
      _errorMessage = null;
      _isLoading = true;
      notifyListeners();
      await _repository.deleteMaterials(id);
      _materials.removeWhere((material) => material.id == id);
      _filteredMaterials.removeWhere((material) => material.id == id);
      return true;
    } catch (e) {
      if (e is DioException) {
        _errorMessage = e.response?.data['message'] ?? 'Server Error';
      } else {
        _errorMessage = e.toString();
      }
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateMaterial(UpdateMaterialsAdminModel material) async {
    try {
      _errorMessage = null;
      _isLoading = true;
      notifyListeners();
      await _repository.updateMaterials(material);
      await loadMaterials();
      return true;
    } catch (e) {
      if (e is DioException) {
        _errorMessage = e.response?.data['message'] ?? 'Server Error';
      } else {
        _errorMessage = e.toString();
      }
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
