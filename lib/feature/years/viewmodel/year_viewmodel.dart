import 'package:flutter/widgets.dart';
import '../model/year_model.dart';

import '../repository/year_repository.dart';

class YearViewmodel extends ChangeNotifier {
  final YearRepository _yearRepository;
  YearViewmodel(this._yearRepository);
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<YearModel> _years = [];
  List<YearModel> get years => _years;
  String _searchQuery = '';

  Future<void> loadYears() async {
    _isLoading = true;
    notifyListeners();
    _years = await _yearRepository.getYears();
    _isLoading = false;
    notifyListeners();
  }

  List<YearModel> get filteredYears {
    final years = _years;

    if (_searchQuery.isEmpty) {
      return years;
    }

    return years.where((year) {
      return year.arbName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          year.engName.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  void searchYears(String value) {
    _searchQuery = value;
    notifyListeners();
  }

  Future<void> addYears(YearModel year) async {
    try {
      _isLoading = true;
      notifyListeners();
      await _yearRepository.addYear(year);
      await loadYears();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateYears(int id, YearModel year) async {
    try {
      _isLoading = true;
      notifyListeners();
      await _yearRepository.updateYear(id, year);
      await loadYears();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteYears(int id) async {
    try {
      _isLoading = true;
      notifyListeners();
      await _yearRepository.deleteYear(id);
      await loadYears();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
