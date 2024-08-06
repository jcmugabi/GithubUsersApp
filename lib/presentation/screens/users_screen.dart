import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../domain/entities/user.dart';
import '../theme/colours.dart';
import '../widgets/no_internet_feedback_card.dart';
import '../widgets/user_card.dart';
import '../state/providers/internet_connection_provider.dart';
import '../state/providers/user_list_provider.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late InternetConnectionProvider _connectivityProvider;
  bool isSearching = false;
  bool _dialogShown = false;

  @override
  void initState() {
    super.initState();

    _searchController.addListener(() {
      setState(() {
        isSearching = _searchController.text.isNotEmpty || _locationController.text.isNotEmpty;
      });
    });

    _locationController.addListener(() {
      setState(() {
        isSearching = _searchController.text.isNotEmpty || _locationController.text.isNotEmpty;
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _connectivityProvider = Provider.of<InternetConnectionProvider>(context);
    _connectivityProvider.addListener(_checkConnectivity);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _locationController.dispose();
    _scrollController.dispose();
    // Unsubscribe from connectivity changes
    _connectivityProvider.removeListener(_checkConnectivity);
    super.dispose();
  }

  void _checkConnectivity() {
    if (!_connectivityProvider.isConnected && !_dialogShown) {
      _dialogShown = true;
      showDialog(
        context: context,
        builder: (context) => const NoInternetFeedback(),
      ).then((_) {
        _dialogShown = false;
      });
    }
  }

  void _onUserTap(User user) {
    Navigator.pushNamed(
      context,
      '/userDetails',
      arguments: user.login,
    );
  }

  void _performSearch() {
    final userProvider = Provider.of<UserListProvider>(context, listen: false);
    userProvider.updateSearchQuery(_searchController.text, location: _locationController.text);
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserListProvider>(context);
    final connectivityProvider = Provider.of<InternetConnectionProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Github Users',
          style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    TextField(
                      controller: _searchController,
                      onSubmitted: (_) => _performSearch(),
                      decoration: const InputDecoration(
                        labelText: 'Search by user name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          userProvider.updateSearchQuery(_searchController.text, location: _locationController.text);
                          setState(() {
                            isSearching = _searchController.text.isNotEmpty || _locationController.text.isNotEmpty;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Stack(
                  children: [
                    TextField(
                      controller: _locationController,
                      onSubmitted: (_) => _performSearch(),
                      decoration: const InputDecoration(
                        labelText: 'Search by location',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _locationController.clear();
                          userProvider.updateSearchQuery(_searchController.text, location: _locationController.text);
                          setState(() {
                            isSearching = _searchController.text.isNotEmpty || _locationController.text.isNotEmpty;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (!connectivityProvider.isConnected)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: NoInternetFeedback(),
            ),
          Expanded(
            child: Scrollbar(
              controller: _scrollController,
              thumbVisibility: true,
              thickness: 6.0,
              radius: const Radius.circular(10),
              child: isSearching
                  ? userProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : userProvider.searchedUsers.isEmpty
                  ? const Center(child: Text('No users..'))
                  : ListView.builder(
                controller: _scrollController,
                itemCount: userProvider.searchedUsers.length,
                itemBuilder: (context, index) {
                  final user = userProvider.searchedUsers[index];
                  return GestureDetector(
                    onTap: () => _onUserTap(user),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: UserCard(user: user),
                    ),
                  );
                },
              )
                  : PagedListView<int, User>(
                pagingController: userProvider.pagingController,
                scrollController: _scrollController,
                builderDelegate: PagedChildBuilderDelegate<User>(
                  itemBuilder: (context, user, index) => GestureDetector(
                    onTap: () => _onUserTap(user),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: UserCard(user: user),
                    ),
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
