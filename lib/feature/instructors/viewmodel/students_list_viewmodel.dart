import 'package:flutter/cupertino.dart';

import '../../../core/model/user_model.dart';
import '../../users/repository/users_repository.dart';

class StudentsListViewModel extends ChangeNotifier {
  final UsersRepository usersRepository;

  StudentsListViewModel(this.usersRepository);

  bool isLoading = false;
  List<UserModel> _students = [];
  List<UserModel> get students => _students;
  List<UserModel> _filteredStudents = [];
  bool _isSearching = false;
  List<UserModel> get filteredStudents =>
      _isSearching ? _filteredStudents : _students;
  bool _sortAscending = true;
  bool get sortAscending => _sortAscending;
  int get studentsCount => _students.length;


  void searchStudents(String query) {
    final searchText = query.trim().toLowerCase();
    if (searchText.isEmpty) {
      _isSearching = false;
      _filteredStudents = [];
    } else {
      _isSearching = true;
      _filteredStudents = _students.where((student) {
        return student.fullName.toLowerCase().contains(searchText);
      }).toList();
    }
    notifyListeners();
  }

  Future<void> loadStudents() async {
    try {
      isLoading = true;
      notifyListeners();
      _students = await usersRepository.getUsersByRole('Student');
      _students.sort(
        (a, b) => a.fullName.toLowerCase().compareTo(b.fullName.toLowerCase()),
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void sortStudentsByName() {
    _sortAscending = !_sortAscending;

    _students.sort((a, b) {
      return _sortAscending
          ? a.fullName.toLowerCase().compareTo(b.fullName.toLowerCase())
          : b.fullName.toLowerCase().compareTo(a.fullName.toLowerCase());
    });

    if (_isSearching) {
      _filteredStudents.sort((a, b) {
        return _sortAscending
            ? a.fullName.toLowerCase().compareTo(b.fullName.toLowerCase())
            : b.fullName.toLowerCase().compareTo(a.fullName.toLowerCase());
      });
    }

    notifyListeners();
  }
}
