import 'package:flutter/cupertino.dart';

import '../repository/instructor_repository.dart';

class InstructorViewModel extends ChangeNotifier {
  final InstructorRepository repository;
  InstructorViewModel(this.repository);
  bool isLoading = false;
  Future<void> addInstructor({
    required String email,
    required String fullName,
    required String password,
    required int departmentId,
  }) async {
    try {
      isLoading = true;
      notifyListeners();
      await repository.addInstructor(
        email: email,
        fullName: fullName,
        password: password,
        departmentId: departmentId,
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
