import '../entities/user.dart';
import '../repositories/user_repository.dart';

class GetUsersUseCase {
  final UserRepository repository;

  GetUsersUseCase({required this.repository});

  Future<List<User>> call({required int page, required int perPage}) {
    return repository.getUsers(page: page, perPage: perPage);
  }
}