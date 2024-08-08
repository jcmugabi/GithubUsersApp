import 'package:GithubUsersApp/presentation/theme/colours.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/user.dart';
import '../state/providers/internet_connection_provider.dart';
import '../state/providers/user_details_provider.dart';
import '../widgets/no_internet_feedback_card.dart';
import '../widgets/user_details_card.dart';
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
        builder: (context) => const NoInternetFeedback(),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    final String username = ModalRoute.of(context)?.settings.arguments as String;
    final userDetailsProvider = Provider.of<UserDetailsProvider>(context, listen: false);
    final connectivityProvider = Provider.of<InternetConnectionProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.headerTextColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () async {
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
          return Container(
              color: const Color(0xFFF0F0F0),
              child: ListView(
                  padding: const EdgeInsets.all(0.0),
                  children: [
                  if (!connectivityProvider.isConnected)
          const Padding(
          padding: EdgeInsets.all(16.0),
          child: NoInternetFeedback(),
          ),
          UserDetailsCard(user: user),
          ],
          ),
          );
        },
      ),
    );
  }
}