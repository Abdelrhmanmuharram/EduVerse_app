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

  Future<void> loadYears() async {
    _isLoading = true;
    notifyListeners();
    _years = await _yearRepository.getYears();
    _isLoading = false;
    notifyListeners();
  }
}
