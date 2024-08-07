import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/usecases/get_users_usecase.dart';

class UserListProvider with ChangeNotifier {
  final GetUsersUseCase _getUsersUseCase;
  final PagingController<int, User> _pagingController = PagingController(firstPageKey: 0);

  List<User> _searchedUsers = [ ];
  bool _isLoading = false;
  bool _isSearching = false;

  UserListProvider({required GetUsersUseCase getUsersUseCase})
      : _getUsersUseCase = getUsersUseCase {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  PagingController<int, User> get pagingController => _pagingController;
  List<User> get searchedUsers => _searchedUsers;
  bool get isLoading => _isLoading;
  bool get isSearching => _isSearching;

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await _getUsersUseCase(page: pageKey, perPage: 20);
      final isLastPage = newItems.length < 20;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }
  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }


  void updateSearchQuery(String query, {String? location}) {
    if (query.isEmpty && (location == null || location.isEmpty)) {
      _isSearching = false;
      _searchedUsers = [];
      notifyListeners();
    } else {
      _isSearching = true;
      searchUsers(query: query, location: location);
    }
  }

  Future<void> searchUsers({String? query, String? location}) async {
    _isLoading = true;
    notifyListeners();

    try {
      _searchedUsers = await _getUsersUseCase(page: 1, perPage: 20, query: query, location: location);
    } catch (e) {
      _searchedUsers = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearSearch() {
    _isSearching = false;
    _searchedUsers = [];
    notifyListeners();
  }
}