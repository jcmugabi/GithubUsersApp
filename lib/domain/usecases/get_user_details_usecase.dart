import '../entities/user.dart';
import '../repositories/user_repository.dart';

class GetUserDetailsUseCase {
  final UserRepository repository;

  GetUserDetailsUseCase({required this.repository});

  Future<User> call(String username) {
    return repository.getUserDetails(username);
  }
}
