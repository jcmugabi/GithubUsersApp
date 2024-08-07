import 'package:GithubUsersApp/presentation/theme/colours.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../domain/entities/user.dart';
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
  bool isSearching = false;
  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      final userProvider = Provider.of<UserListProvider>(context, listen: false);
      userProvider.updateSearchQuery(_searchController.text, location: _locationController.text);
      setState(() {
        isSearching = _searchController.text.isNotEmpty || _locationController.text.isNotEmpty;
      });
    });
    _locationController.addListener(() {
      final userProvider = Provider.of<UserListProvider>(context, listen: false);
      userProvider.updateSearchQuery(_searchController.text, location: _locationController.text);
      setState(() {
        isSearching = _searchController.text.isNotEmpty || _locationController.text.isNotEmpty;
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
    _locationController.dispose();
    final connectivityProvider = Provider.of<InternetConnectionProvider>(context, listen: false);
    connectivityProvider.removeListener(_checkConnectivity);
    super.dispose();
  }
  void _checkConnectivity() {
    final connectivityProvider = Provider.of<InternetConnectionProvider>(context, listen: true);
    if (!connectivityProvider.isConnected) {
      showDialog(
        context: context,
        builder: (context) => const NoInternetFeedback(),
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
    final userProvider = Provider.of<UserListProvider>(context);
    final connectivityProvider = Provider.of<InternetConnectionProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Github Users',
          style: TextStyle(color: AppColors.headerTextColor),
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
                    final userProvider = Provider.of<UserListProvider>(context, listen: false);
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
                    final userProvider = Provider.of<UserListProvider>(context, listen: false);
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
    Padding(
    padding: const EdgeInsets.all(16.0),
    child: NoInternetFeedback(),
    ),
    Expanded(
    child: Scrollbar(
    thumbVisibility: true,
    thickness: 6.0,
    radius: const Radius.circular(10),
    child: isSearching
    ? userProvider.isLoading
    ? const Center(child: CircularProgressIndicator())
        : userProvider.searchedUsers.isEmpty
    ? const Center(child: Text('No users found'))
        : ListView.builder(
    itemCount: userProvider.searchedUsers.length,
    itemBuilder: (context, index) {
    final user = userProvider.searchedUsers[index];
    return GestureDetector(
    onTap: () => _onUserTap(user),
    child: UserCard(user: user),
    );
    },
    )
        : PagedListView<int, User>(
    pagingController: userProvider.pagingController,
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