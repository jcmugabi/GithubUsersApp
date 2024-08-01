import 'package:flutter/material.dart';
import '../../domain/entities/user.dart';
import '../theme/styles.dart';

class UserCard extends StatelessWidget {
  final User user;

  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(user.avatarUrl),
        ),
        title: Text(user.login, style: AppStyles.bodyText),
      ),
      ),
    );
  }
}
