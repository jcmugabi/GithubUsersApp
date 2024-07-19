import '../entities/user.dart';
import '../repositories/user_repository.dart';

/// Use case for fetching details of a specific user.
class GetUserDetailsUseCase {
  final UserRepository repository; // Reference to the user repository

  GetUserDetailsUseCase({required this.repository});

  Future<User> call(String username) {
    return repository.getUserDetails(username); // Calls the repository method to fetch user details
  }
}
