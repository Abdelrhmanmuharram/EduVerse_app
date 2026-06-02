import 'package:flutter/cupertino.dart';

import '../../../core/model/user_model.dart';
import '../repository/users_repository.dart';

class UsersViewmodel extends ChangeNotifier{
  final UsersRepository repo;
  UsersViewmodel(this.repo);
  List<UserModel> users = [];
  bool _isLoading = false;
  Future<void> getUsersByRole(String role) async {
    _isLoading = true;
    notifyListeners();
    try {
      users = await repo.getUsersByRole(role);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}