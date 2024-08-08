import 'package:flutter/material.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/usecases/get_user_details_usecase.dart';

class UserDetailsProvider with ChangeNotifier {
  final GetUserDetailsUseCase _getUserDetailsUseCase;
  User? _userDetails;

  UserDetailsProvider({required GetUserDetailsUseCase getUserDetailsUseCase})
      : _getUserDetailsUseCase = getUserDetailsUseCase;

  User? get userDetails => _userDetails;

  Future<User?> fetchUserDetails(String userId) async {
    try {
      _userDetails = await _getUserDetailsUseCase(userId);
      notifyListeners();
      print(_userDetails);
      return _userDetails;
    } catch (e) {
      _userDetails = null;
      notifyListeners();
      print(e);
      return null;
    }
  }
}