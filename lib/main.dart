import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:GithubUsersApp/presentation/screens/splash_screen.dart';
import 'package:GithubUsersApp/presentation/screens/users_screen.dart';
import 'package:GithubUsersApp/presentation/screens/user_details_screen.dart';
import 'package:GithubUsersApp/presentation/state/providers/connectivity_provider.dart';
import 'package:GithubUsersApp/presentation/state/providers/users_paging_controller_provider.dart';
import 'package:GithubUsersApp/domain/usecases/get_users_usecase.dart';
import 'package:GithubUsersApp/data/repositories/user_repository_impl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ConnectivityProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => UsersPagingControllerProvider(
            getUsersUseCase: GetUsersUseCase(
              repository: UserRepositoryImpl(),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Github Users App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scrollbarTheme: ScrollbarThemeData(
            thumbColor: MaterialStateProperty.all(const Color(0xFF000080)), // Navy Blue
            thickness: MaterialStateProperty.all(6.0),
            radius: const Radius.circular(10),
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/users': (context) => const UsersScreen(),
          '/userDetails': (context) => UserDetailsScreen(),
        },
      ),
    );
  }
}
