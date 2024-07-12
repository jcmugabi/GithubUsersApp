// lib/main.dart

import 'package:flutter/material.dart';
import 'pages/users.dart';
import 'pages/about.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Navigation Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/users',
      routes: {
        '/users': (context) => const UsersPage(),
        '/about': (context) => const AboutPage(),
      },
    );
  }
}
