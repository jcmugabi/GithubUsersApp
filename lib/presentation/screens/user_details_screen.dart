import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/user.dart';
import '../state/providers/internet_connection_provider.dart';
import '../state/providers/user_details_provider.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key});

  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final connectivityProvider = Provider.of<InternetConnectionProvider>(context, listen: false);
      connectivityProvider.addListener(_checkConnectivity);
    });
  }

  @override
  void dispose() {
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


  @override
  Widget build(BuildContext context) {
    final String username = ModalRoute.of(context)?.settings.arguments as String;
    final userDetailsProvider = Provider.of<UserDetailsProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () async {
              final userDetailsProvider = Provider.of<UserDetailsProvider>(context, listen: false);
              final user = await userDetailsProvider.fetchUserDetails(username);
              if (user != null) {
                Share.share('Check out this GitHub user: github.com/${user.login}');
              }
            },
          ),
        ],
      ),
        body: FutureBuilder<User?>(
        future: userDetailsProvider.fetchUserDetails(username),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading user details'));
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
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
