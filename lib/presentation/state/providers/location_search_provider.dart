// import 'package:flutter/material.dart';
// import '../../../domain/entities/user.dart';
// import '../../../domain/usecases/search_location_usecase.dart';
// import '../../../domain/usecases/get_users_usecase.dart';
//
// class LocationSearchProvider with ChangeNotifier {
//   final SearchLocationUseCase _searchLocationUseCase;
//   final GetUsersUseCase _getUsersUseCase;
//
//   List<User> _initialUsers = [];
//   List<User> _searchedUsers = [];
//   bool _isLoading = false;
//   bool _isSearching = false;
//
//   LocationSearchProvider({required SearchLocationUseCase searchLocationUseCase, required GetUsersUseCase getUsersUseCase})
//       : _searchLocationUseCase = searchLocationUseCase,
//         _getUsersUseCase = getUsersUseCase {
//     loadInitialUsers(page: 1, perPage: 20);
//   }
//
//   List<User> get users => _isSearching ? _searchedUsers : _initialUsers;
//   bool get isLoading => _isLoading;
//
//   void loadInitialUsers({required int page, required int perPage}) async {
//     _isLoading = true;
//     notifyListeners();
//
//     try {
//       _initialUsers = await _getUsersUseCase(page: page, perPage: perPage);
//     } catch (e) {
//       _initialUsers = [];
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
//
//   void updateSearchQuery(String query) {
//     if (query.isEmpty) {
//       clearSearch();
//     } else {
//       _isSearching = true;
//       searchUsers(query: query);
//     }
//   }
//
//   Future<void> searchUsers({required String query}) async {
//     _isLoading = true;
//     notifyListeners();
//
//     try {
//       _searchedUsers = await _searchLocationUseCase(query: query);
//     } catch (e) {
//       _searchedUsers = [];
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
//
//   void clearSearch() {
//     _isSearching = false;
//     _searchedUsers = [];
//     loadInitialUsers(page: 1, perPage: 20);
//   }
// }
