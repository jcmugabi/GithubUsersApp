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
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  bool isSearchingByUsername = false;
  bool isSearchingByLocation = false;

  @override
  void initState() {
    super.initState();

    _usernameController.addListener(() {
      final searchProvider = Provider.of<SearchProvider>(context, listen: false);
      if (_usernameController.text.isNotEmpty) {
        _locationController.clear();
        searchProvider.updateSearchQuery(_usernameController.text, byLocation: false);
        setState(() {
          isSearchingByUsername = true;
          isSearchingByLocation = false;
        });
      } else {
        searchProvider.clearSearch();
        setState(() {
          isSearchingByUsername = false;
        });
      }
    });

    _locationController.addListener(() {
      final searchProvider = Provider.of<SearchProvider>(context, listen: false);
      if (_locationController.text.isNotEmpty) {
        _usernameController.clear();
        searchProvider.updateSearchQuery(_locationController.text, byLocation: true);
        setState(() {
          isSearchingByLocation = true;
          isSearchingByUsername = false;
        });
      } else {
        searchProvider.clearSearch();
        setState(() {
          isSearchingByLocation = false;
        });
      }
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
    _usernameController.dispose();
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
        backgroundColor: const Color(0xFF000080), // Navy Blue
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Search by username',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: TextField(
                    controller: _locationController,
                    decoration: const InputDecoration(
                      labelText: 'Search by location',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _usernameController.clear();
                    _locationController.clear();
                    searchProvider.clearSearch();
                  },
                ),
              ],
            ),
          ),
          if (!connectivityProvider.isConnected) // Displaying the connectivity status
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: connectivityProvider.getFeedbackCard(),
            ),
          Expanded(
            child: Scrollbar(
              thumbVisibility: true,
              thickness: 6.0,
              radius: const Radius.circular(10),
              child: searchProvider.isLoading
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
