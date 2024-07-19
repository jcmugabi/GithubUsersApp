import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/get_users_usecase.dart';

class UsersPagingController extends ChangeNotifier {
  static const int _pageSize = 15;
  final GetUsersUseCase getUsersUseCase;
  final PagingController<int, User> pagingController = PagingController(firstPageKey: 1);

  String? _searchQuery;

  UsersPagingController({required this.getUsersUseCase}) {
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await getUsersUseCase(page: pageKey, perPage: _pageSize, query: _searchQuery);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  void updateSearchQuery(String? query) {
    if (query?.isEmpty ?? true) {
      _searchQuery = null;
    } else {
      _searchQuery = query;
    }
    pagingController.refresh();
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }
}

// void updateSearchQuery(String? query) {
//   if (query?.isEmpty ?? true) {
//     _searchQuery = null;
//   } else {
//     _searchQuery = query;
//   }
//   pagingController.refresh();
// }
