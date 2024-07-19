import 'package:flutter/material.dart';
import 'package:GithubUsersApp/presentation/screens/splash_screen.dart';
import 'package:GithubUsersApp/presentation/screens/users_screen.dart';
import 'package:GithubUsersApp/presentation/screens/user_details_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Github Users App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scrollbarTheme: ScrollbarThemeData(
          thumbColor: MaterialStateProperty.all(Color(0xFF000080)), // Navy Blue
          thickness: MaterialStateProperty.all(6.0),
          radius: Radius.circular(10),
        ),
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
