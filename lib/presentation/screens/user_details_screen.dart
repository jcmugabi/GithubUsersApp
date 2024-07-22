import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/get_user_details_usecase.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../theme/styles.dart';
import 'package:share/share.dart';
import '../state/providers/connectivity_provider.dart';
import '../widgets/no_internet_dialog.dart';

class UserDetailsScreen extends StatefulWidget {
  final GetUserDetailsUseCase getUserDetailsUseCase = GetUserDetailsUseCase(
    repository: UserRepositoryImpl(),
  );

  UserDetailsScreen({super.key});

  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  @override
  void initState() {
    super.initState();
    // Listen for connectivity changes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final connectivityProvider = Provider.of<ConnectivityProvider>(context, listen: true);
      connectivityProvider.addListener(_checkConnectivity);
    });
  }

  @override
  void dispose() {
    final connectivityProvider = Provider.of<ConnectivityProvider>(context, listen: false);
    connectivityProvider.removeListener(_checkConnectivity);
    super.dispose();
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
    final String username = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () async {
              final User user = await widget.getUserDetailsUseCase(username);
              Share.share('Check out this GitHub user: ${user.login}, ${user.avatarUrl}');
            },
          ),
        ],
      ),
      body: FutureBuilder<User>(
        future: widget.getUserDetailsUseCase(username),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: NoInternetDialog());
          } else if (!snapshot.hasData) {
            return const Center(child: Text('User not found'));
          }

          final user = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(user.avatarUrl),
                    radius: 50,
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    user.login,
                    style: AppStyles.headline,
                  ),
                ),
                const SizedBox(height: 16),
                Text('Name: ${user.name}'),
                const SizedBox(height: 8),
                Text('Followers: ${user.followers}'),
                const SizedBox(height: 8),
                Text('Following: ${user.following}'),
                const SizedBox(height: 8),
                Text('Type: ${user.type}'),
                const SizedBox(height: 8),
                Text('Bio: ${user.bio}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
