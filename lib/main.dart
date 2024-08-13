import 'package:GithubUsersApp/injector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/remote/api_data.dart';
import 'domain/usecases/get_user_details_usecase.dart';
import 'domain/usecases/get_users_usecase.dart';
// import 'data/repositories/user_repository_impl.dart';
import 'presentation/state/providers/internet_connection_provider.dart';
import 'presentation/state/providers/user_details_provider.dart';
import 'presentation/state/providers/user_list_provider.dart';
import 'presentation/screens/splash_screen.dart';
import 'presentation/screens/users_screen.dart';
import 'presentation/screens/user_details_screen.dart';

void main() {
  setup();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => InternetConnectionProvider()),
        ChangeNotifierProvider(
          create: (_) => UserDetailsProvider(
            getUserDetailsUseCase: GetUserDetailsUseCase(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => UserListProvider(
            getUsersUseCase: GetUsersUseCase(),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

final apiData = ApiData();

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
          thumbColor: WidgetStateProperty.all(const Color(0xFFffffff)),
          thickness: WidgetStateProperty.all(6.0),
          radius: const Radius.circular(10),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/users': (context) => const UsersScreen(),
        '/userDetails': (context) => const UserDetailsScreen(),
      },
    );
  }
}
