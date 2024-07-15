// lib/screens/user_details_page.dart

import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/api_service.dart';

class UserDetailsPage extends StatefulWidget {
  final String username;

  const UserDetailsPage({Key? key, required this.username}) : super(key: key);

  @override
  _UserDetailsPageState createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  late Future<UserDetails> _userDetails;

  @override
  void initState() {
    super.initState();
    _userDetails = ApiService().fetchUserDetails(widget.username);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
        backgroundColor: const Color(0xFF000080), // Navy Blue
      ),
      body: FutureBuilder<UserDetails>(
        future: _userDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data'));
          } else {
            UserDetails userDetails = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(userDetails.avatarUrl),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text('Username: ${userDetails.login}', style: TextStyle(fontSize: 18)),
                  const SizedBox(height: 8),
                  Text('Name: ${userDetails.name ?? "N/A"}', style: TextStyle(fontSize: 18)),
                  const SizedBox(height: 8),
                  Text('Followers: ${userDetails.followers}', style: TextStyle(fontSize: 18)),
                  const SizedBox(height: 8),
                  Text('Following: ${userDetails.following}', style: TextStyle(fontSize: 18)),
                  const SizedBox(height: 8),
                  Text('GitHub URL: ${userDetails.htmlUrl}', style: TextStyle(fontSize: 18, color: Colors.blue)),
                  const SizedBox(height: 8),
                  Text('Email: ${userDetails.email ?? "N/A"}', style: TextStyle(fontSize: 18)),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
