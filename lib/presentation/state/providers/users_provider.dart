import 'package:flutter/material.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/usecases/get_users_usecase.dart';

class UsersProvider with ChangeNotifier {
  final GetUsersUseCase _getUsersUseCase;
  List<User> _users = [];

  UsersProvider({required GetUsersUseCase getUsersUseCase}) : _getUsersUseCase = getUsersUseCase;

  List<User> get users => _users;

  Future<void> fetchUsers(int page, int perPage) async {
    try {
      _users = await _getUsersUseCase(page: page, perPage: perPage);
      notifyListeners();
    } catch (e) {
      _users = [];
      notifyListeners();
    }
  }
}
