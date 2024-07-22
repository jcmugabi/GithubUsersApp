import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/usecases/get_users_usecase.dart';
import '../../widgets/no_internet_dialog.dart';

class UsersPagingControllerProvider with ChangeNotifier {
  final GetUsersUseCase _getUsersUseCase;
  final PagingController<int, User> _pagingController = PagingController(firstPageKey: 0);

  UsersPagingControllerProvider({
    required GetUsersUseCase getUsersUseCase,
  })   : _getUsersUseCase = getUsersUseCase {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  PagingController<int, User> get pagingController => _pagingController;

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await _getUsersUseCase(
        page: pageKey,
        perPage: 20,
      );
      final isLastPage = newItems.length < 20;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = const NoInternetDialog();
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
