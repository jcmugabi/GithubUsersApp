import 'package:flutter/material.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/get_user_details_usecase.dart';
import '../theme/styles.dart';
import '../../data/repositories/user_repository_impl.dart';
import 'package:share/share.dart';

class UserDetailsScreen extends StatelessWidget {
  final GetUserDetailsUseCase getUserDetailsUseCase = GetUserDetailsUseCase(
    repository: UserRepositoryImpl(),
  );

  UserDetailsScreen({super.key});

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
              final User user = await getUserDetailsUseCase(username);
              Share.share('Check out this GitHub user: ${user.login}, ${user.avatarUrl}');
            },
          ),
        ],
      ),
      body: FutureBuilder<User>(
        future: getUserDetailsUseCase(username),
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
                    style: AppStyles.headline,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Name: ${user.name}',
                  // style: AppStyles.subhead,
                ),
                const SizedBox(height: 8),
                Text(
                  'Followers: ${user.followers}',
                  // style: AppStyles.subhead,
                ),
                const SizedBox(height: 8),
                Text(
                  'Following: ${user.following}',
                  // style: AppStyles.subhead,
                ),
                const SizedBox(height: 8),
                Text(
                  'Type: ${user.type}',
                  // style: AppStyles.subhead,
                ),
                const SizedBox(height: 8),
                Text(
                  'Bio: ${user.bio}',
                  // style: AppStyles.subhead,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
