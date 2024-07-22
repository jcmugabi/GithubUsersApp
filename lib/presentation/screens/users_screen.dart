import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../domain/entities/user.dart';
// import '../theme/styles.dart';
import '../widgets/user_card.dart';
import '../widgets/no_internet_dialog.dart';
import '../state/providers/connectivity_provider.dart';
import '../state/providers/users_paging_controller_provider.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Listen for connectivity changes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final connectivityProvider = Provider.of<ConnectivityProvider>(context, listen: true);
      connectivityProvider.addListener(_checkConnectivity);
    });
    _searchController.addListener(() {
      final usersPagingController = Provider.of<UsersPagingControllerProvider>(context, listen: false);
      usersPagingController.pagingController.refresh();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();

    final connectivityProvider = Provider.of<ConnectivityProvider>(context, listen: false);
    connectivityProvider.removeListener(_checkConnectivity);
    super.dispose();
  }

  void _onUserTap(User user) {
    Navigator.pushNamed(
      context,
      '/userDetails',
      arguments: user.login,
    );
  }

  void _checkConnectivity() {
    final connectivityProvider = Provider.of<ConnectivityProvider>(context, listen: false);
    if (!connectivityProvider.isConnected) {
      showDialog(
        context: context,
        builder: (context) => const NoInternetDialog(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final connectivityProvider = Provider.of<ConnectivityProvider>(context);
    final usersPagingController = Provider.of<UsersPagingControllerProvider>(context);

    if (!connectivityProvider.isConnected) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (context) => const NoInternetDialog(),
        );
      });
    }

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
          Expanded(
            child: Scrollbar(
              thumbVisibility: true,
              thickness: 6.0,
              radius: const Radius.circular(10),
              child: PagedListView<int, User>(
                pagingController: usersPagingController.pagingController,
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
