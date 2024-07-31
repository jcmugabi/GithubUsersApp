import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/remote/api_data.dart';
import 'domain/usecases/get_user_details_usecase.dart';
import 'domain/usecases/get_users_usecase.dart';
import 'data/repositories/user_repository_impl.dart';
import 'presentation/state/providers/internet_connection_provider.dart';
import 'presentation/state/providers/user_details_provider.dart';
import 'presentation/state/providers/user_list_provider.dart';
import 'presentation/screens/splash_screen.dart';
import 'presentation/screens/users_screen.dart';
import 'presentation/screens/user_details_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => InternetConnectionProvider()),
        ChangeNotifierProvider(
          create: (_) => UserDetailsProvider(
            getUserDetailsUseCase: GetUserDetailsUseCase(repository: UserRepositoryImpl(apiData)),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => UserListProvider(
            getUsersUseCase: GetUsersUseCase(repository: UserRepositoryImpl(apiData)),
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
          thumbColor: WidgetStateProperty.all(const Color(0xFF000080)),
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
