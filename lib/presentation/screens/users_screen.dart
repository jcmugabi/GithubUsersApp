import 'package:flutter/material.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/get_users_usecase.dart';
import '../theme/styles.dart';
import '../widgets/user_card.dart';
import '../widgets/pagination.dart';
import '../../data/repositories/user_repository_impl.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final GetUsersUseCase getUsersUseCase = GetUsersUseCase(
    repository: UserRepositoryImpl(),
  );

  List<User> _users = [];
  List<User> _filteredUsers = [];
  int _currentPage = 1;
  bool _isLoading = false;
  final int _perPage = 15;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUsers();
    _searchController.addListener(() {
      _filterUsers(_searchController.text);
    });
  }

  Future<void> _fetchUsers({int page = 1}) async {
    setState(() {
      _isLoading = true;
    });
    List<User> users = await getUsersUseCase(page: page, perPage: _perPage);
    setState(() {
      _users = users;
      _filteredUsers = users;
      _isLoading = false;
    });
  }

  void _filterUsers(String query) {
    List<User> filtered = _users
        .where((user) => user.login.toLowerCase().contains(query.toLowerCase()))
        .toList();

    setState(() {
      _filteredUsers = filtered;
    });
  }

  void _goToPreviousPage() {
    if (_currentPage > 1) {
      _currentPage--;
      _fetchUsers(page: _currentPage);
    }
  }

  void _goToNextPage() {
    _currentPage++;
    _fetchUsers(page: _currentPage);
  }

  void _onUserTap(User user) {
    Navigator.pushNamed(
      context,
      '/userDetails',
      arguments: user.login,
    );
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
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Users',
              style: AppStyles.headline,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search Users in Uganda',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
              itemCount: _filteredUsers.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _onUserTap(_filteredUsers[index]),
                  child: UserCard(user: _filteredUsers[index]),
                );
              },
            ),
          ),
          if (!_isLoading)
            Pagination(
              currentPage: _currentPage,
              onPreviousPage: _goToPreviousPage,
              onNextPage: _goToNextPage,
            ),
        ],
      ),
    );
  }
}
