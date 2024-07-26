// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import '../../../presentation/state/providers/search_provider.dart';
// import '../../../presentation/state/providers/internet_connection_provider.dart';
// import '../../../presentation/state/providers/user_details_provider.dart';
// import '../../../presentation/state/providers/infinite_scroll_provider.dart';
// import '../../../presentation/screens/splash_screen.dart';
// import '../../../presentation/screens/users_screen.dart';
// import '../../../presentation/screens/user_details_screen.dart';
// import '../../../domain/usecases/get_user_details_usecase.dart';
// import '../../../domain/usecases/get_users_usecase.dart';
// import '../../../domain/usecases/search_users_usecase.dart';
// import '../../../domain/usecases/search_location_usecase.dart';
// import '../../../data/repositories/user_repository_impl.dart';
//
// void main() {
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(
//           create: (_) => SearchProvider(
//             searchUsersUseCase: SearchUsersUseCase(
//               repository: UserRepositoryImpl(),
//             ),
//             getUsersUseCase: GetUsersUseCase(
//               repository: UserRepositoryImpl(),
//             ),
//             searchLocationUseCase: SearchLocationUseCase(
//               repository: UserRepositoryImpl(),
//             ),
//           ),
//         ),
//         ChangeNotifierProvider(
//           create: (_) => InternetConnectionProvider(Connectivity()),
//         ),
//         ChangeNotifierProvider(
//           create: (_) => UserDetailsProvider(
//             getUserDetailsUseCase: GetUserDetailsUseCase(
//               repository: UserRepositoryImpl(),
//             ),
//           ),
//         ),
//         ChangeNotifierProvider(
//           create: (_) => InfiniteScrollProvider(
//             getUsersUseCase: GetUsersUseCase(
//               repository: UserRepositoryImpl(),
//             ),
//           ),
//         ),
//       ],
//       child: const MyApp(),
//     ),
//   );
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'GitHub Users',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       initialRoute: '/',
//       routes: {
//         '/': (context) => const SplashScreen(),
//         '/users': (context) => const UsersScreen(),
//         '/userDetails': (context) => const UserDetailsScreen(),
//       },
//     );
//   }
// }
