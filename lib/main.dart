import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../presentation/state/providers/search_provider.dart';
import '../../../presentation/state/providers/internet_connection_provider.dart';
import '../../../presentation/state/providers/user_details_provider.dart';
import '../../../presentation/state/providers/users_provider.dart';
import '../../../presentation/state/providers/infinite_scroll_provider.dart';
import '../../../presentation/screens/splash_screen.dart';
import '../../../presentation/screens/users_screen.dart';
import '../../../presentation/screens/user_details_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../../domain/usecases/get_user_details_usecase.dart';
import '../../../domain/usecases/get_users_usecase.dart';
// import '../../../domain/usecases/search_users_usecase.dart';
import '../../../data/repositories/user_repository_impl.dart';
import '../../../domain/usecases/search_users_usecase.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [

        ChangeNotifierProvider(
          create: (_) => SearchProvider(
            searchUsersUseCase: SearchUsersUseCase(
              repository: UserRepositoryImpl(),
            ),
            getUsersUseCase: GetUsersUseCase(
              repository: UserRepositoryImpl(),
            ),
          ),
        ),
        ChangeNotifierProvider(create: (_) => InternetConnectionProvider(Connectivity())),
        ChangeNotifierProvider(create: (_) => UserDetailsProvider(
          getUserDetailsUseCase: GetUserDetailsUseCase(repository: UserRepositoryImpl()),
        )),
        ChangeNotifierProvider(create: (_) => UsersProvider(
          getUsersUseCase: GetUsersUseCase(repository: UserRepositoryImpl()),
        )),
        ChangeNotifierProvider(create: (_) => InfiniteScrollProvider(
          getUsersUseCase: GetUsersUseCase(repository: UserRepositoryImpl()),
        )),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Github Users App- Uganda',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scrollbarTheme: ScrollbarThemeData(
          thumbColor: WidgetStateProperty.all(const Color(0xFF000080)), // Navy Blue
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
