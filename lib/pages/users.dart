import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/api_service.dart';
import '../widgets/user_card.dart';
import '../widgets/navbar.dart';
import '../widgets/pagination.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  UsersPageState createState() => UsersPageState();
}

class UsersPageState extends State<UsersPage> {
  List<User> _users = [];
  List<User> _filteredUsers = [];
  int _currentPage = 1;
  bool _isLoading = false;
  final int _perPage = 10;
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
    List<User> users = await ApiService().fetchUsers(page: page, perPage: _perPage);
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
              style: TextStyle(fontSize: 24),
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
                return UserCard(user: _filteredUsers[index]);
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
      bottomNavigationBar: const NavBar(currentIndex: 0),
    );
  }
}
