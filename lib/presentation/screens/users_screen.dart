import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/get_users_usecase.dart';
import '../../domain/usecases/filter_users_by_type_usecase.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../theme/styles.dart';
import '../widgets/user_card.dart';
import '../state/users_paging_controller.dart';
import '../widgets/filter_button.dart'; // Import the FilterButton widget
import '../widgets/filter_dropdown.dart'; // Import the FilterDropdown widget

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  late UsersPagingController _usersPagingController;
  final TextEditingController _searchController = TextEditingController();
  String _filterSelection = 'All'; // State variable to store the filter selection

  @override
  void initState() {
    super.initState();
    _usersPagingController = UsersPagingController(
      getUsersUseCase: GetUsersUseCase(
        repository: UserRepositoryImpl(),
      ),
      filterUsersByTypeUseCase: FilterUsersByTypeUseCase(
        repository: UserRepositoryImpl(),
      ),
    );
    _searchController.addListener(() {
      _usersPagingController.updateSearchQuery(_searchController.text, _filterSelection);
    });
  }

  @override
  void dispose() {
    _usersPagingController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onUserTap(User user) {
    Navigator.pushNamed(
      context,
      '/userDetails',
      arguments: user.login,
    );
  }

  void _onFilterChanged(String? filterType) {
    setState(() {
      _filterSelection = filterType ?? 'All';
      _usersPagingController.updateSearchQuery(_searchController.text, _filterSelection);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Github Users',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF000080), // Navy Blue
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search Users in Uganda',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FilterButton(),
              ],
            ),
          ),
          Expanded(
            child: Scrollbar(
              thumbVisibility: true,
              thickness: 6.0,
              radius: Radius.circular(10),
              child: PagedListView<int, User>(
                pagingController: _usersPagingController.pagingController,
                builderDelegate: PagedChildBuilderDelegate<User>(
                  itemBuilder: (context, user, index) => GestureDetector(
                    onTap: () => _onUserTap(user),
                    child: UserCard(user: user),
                  ),
                ),
              ),
            ),
          ),
          FilterDropdown(
            onChanged: _onFilterChanged,
          ),
        ],
      ),
    );
  }
}
