import '../entities/user.dart';
import '../repositories/user_repository.dart';

class SearchLocationUseCase {
  final UserRepository repository;

  SearchLocationUseCase({required this.repository});

  Future<List<User>> call({required String query}) {
    return repository.searchUsers(query);
  }
}
