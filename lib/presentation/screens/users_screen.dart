import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../domain/entities/user.dart';
import '../widgets/user_card.dart';
import '../state/providers/internet_connection_provider.dart';
import '../state/providers/search_provider.dart';
import '../state/providers/infinite_scroll_provider.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool isSearching = false;

  @override
  void initState() {
    super.initState();

    _searchController.addListener(() {
      final searchProvider = Provider.of<SearchProvider>(context, listen: false);
      searchProvider.updateSearchQuery(_searchController.text);
      setState(() {
        isSearching = _searchController.text.isNotEmpty;
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final connectivityProvider = Provider.of<InternetConnectionProvider>(context, listen: true);
      connectivityProvider.addListener(_checkConnectivity);

      if (!connectivityProvider.isConnected) {
        _checkConnectivity();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    final connectivityProvider = Provider.of<InternetConnectionProvider>(context, listen: false);
    connectivityProvider.removeListener(_checkConnectivity);
    super.dispose();
  }

  void _checkConnectivity() {
    final connectivityProvider = Provider.of<InternetConnectionProvider>(context, listen: true);
    if (!connectivityProvider.isConnected) {
      showDialog(
        context: context,
        builder: (context) => connectivityProvider.getFeedbackCard(),
      );
    }
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
    final infiniteScrollProvider = Provider.of<InfiniteScrollProvider>(context);
    final searchProvider = Provider.of<SearchProvider>(context);
    final connectivityProvider = Provider.of<InternetConnectionProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Github Users',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF000080),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      labelText: 'Search by user name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    searchProvider.clearSearch();
                    infiniteScrollProvider.pagingController.refresh();
                  },
                ),
              ],
            ),
          ),
          if (!connectivityProvider.isConnected)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: connectivityProvider.getFeedbackCard(),
            ),
          Expanded(
            child: Scrollbar(
              thumbVisibility: true,
              thickness: 6.0,
              radius: const Radius.circular(10),
              child: isSearching
                  ? searchProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : searchProvider.users.isEmpty
                  ? const Center(child: Text('No users found'))
                  : ListView.builder(
                itemCount: searchProvider.users.length,
                itemBuilder: (context, index) {
                  final user = searchProvider.users[index];
                  return GestureDetector(
                    onTap: () => _onUserTap(user),
                    child: UserCard(user: user),
                  );
                },
              )
                  : PagedListView<int, User>(
                pagingController: infiniteScrollProvider.pagingController,
                builderDelegate: PagedChildBuilderDelegate<User>(
                  itemBuilder: (context, user, index) => GestureDetector(
                    onTap: () => _onUserTap(user),
                    child: UserCard(user: user),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
