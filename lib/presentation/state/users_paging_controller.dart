import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/get_users_usecase.dart';
import '../../domain/usecases/filter_users_by_type_usecase.dart';

class UsersPagingController {
  final GetUsersUseCase getUsersUseCase;
  final FilterUsersByTypeUseCase filterUsersByTypeUseCase;
  final PagingController<int, User> pagingController = PagingController(firstPageKey: 0);
  String? searchQuery;
  String? filterType;

  UsersPagingController({
    required this.getUsersUseCase,
    required this.filterUsersByTypeUseCase,
  }) {
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  void updateSearchQuery(String? query, String? filterType) {
    searchQuery = query;
    this.filterType = filterType;
    pagingController.refresh();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await getUsersUseCase(
          page: pageKey,
          perPage: 20,
          query: searchQuery,
          filterType: filterType ?? 'All' // Provide a default value if filterType is null
      );

      final isLastPage = newItems.length < 20;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  void dispose() {
    pagingController.dispose();
  }
}
