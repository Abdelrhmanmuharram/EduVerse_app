import 'package:flutter/cupertino.dart';

import '../../../../core/services/pdf_cache_service.dart';
import '../../instructors/repository/instructor_subject_repository.dart';
import '../model/materials_admin_model.dart';
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
}
