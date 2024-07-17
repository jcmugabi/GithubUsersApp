import 'package:GithubUsersApp/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
// import 'presentation/screens/splash_screen.dart';
import 'presentation/screens/users_screen.dart';
import 'presentation/screens/user_details_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Github Users',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/users': (context) => const UsersScreen(),
        '/userDetails': (context) => UserDetailsScreen(),
      },
    );
  }
}
