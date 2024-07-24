import '../entities/user.dart';
import '../repositories/user_repository.dart';

class SearchUsersUseCase {
  final UserRepository repository;

  SearchUsersUseCase({required this.repository});

  Future<List<User>> call({required String query}) {
    return repository.searchUsers(query);
  }
}
