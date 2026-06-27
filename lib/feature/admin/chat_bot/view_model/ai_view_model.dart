import 'package:flutter/material.dart';
import '../../materials/model/materials_admin_model.dart';
import '../repository/ai_repository.dart';

class AiViewModel extends ChangeNotifier {
  final AiRepository _repository;

  AiViewModel(this._repository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  List<MaterialsAdminModel> _materials = [];
  List<MaterialsAdminModel> get materials => _materials;

  final List<int> _selectedMaterialIds = [];
  List<int> get selectedMaterialIds => _selectedMaterialIds;

  int? _selectedSubjectId;
  int? get selectedSubjectId => _selectedSubjectId;

  String? _selectedSubjectName;
  String? get selectedSubjectName => _selectedSubjectName;

  Future<void> selectSubject({
    required int subjectId,
    required String subjectName,
  }) async {
    _selectedSubjectId = subjectId;
    _selectedSubjectName = subjectName;
    await loadSubjectMaterials(subjectId);
  }

  void toggleMaterial(int materialId) {
    if (_selectedMaterialIds.contains(materialId)) {
      _selectedMaterialIds.remove(materialId);
    } else {
      _selectedMaterialIds.add(materialId);
    }
    notifyListeners();
  }

  bool isSelected(int materialId) {
    return _selectedMaterialIds.contains(materialId);
  }

  Future<void> loadSubjectMaterials(int subjectId) async {
    try {
      _isLoading = true;
      _errorMessage = '';
      notifyListeners();
      _materials = await _repository.getSubjectMaterials(subjectId);
      _selectedMaterialIds.clear();
    } catch (e) {
      _errorMessage = 'Failed to load materials';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
