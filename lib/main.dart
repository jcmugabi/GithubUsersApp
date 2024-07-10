import 'package:flutter/material.dart';
import 'pages/users.dart';
import 'pages/about.dart';
import 'widgets/navbar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
        '/users': (context) => UsersPage(),
        '/about': (context) => AboutPage(),
      },
    );
  }
}
