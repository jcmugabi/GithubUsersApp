// lib/widgets/user_card.dart

import 'package:flutter/material.dart';
import '../models/user.dart';
import '../pages/user_details_page.dart';

class UserCard extends StatelessWidget {
  final User user;

  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(user.avatarUrl),
        ),
        title: Text(user.login),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserDetailsPage(username: user.login),
            ),
          );
        },
      ),
    );
  }
}
