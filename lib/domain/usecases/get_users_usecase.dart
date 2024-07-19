import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';

class GetUsersUseCase {
  final UserRepository repository;

  GetUsersUseCase({required this.repository});

  Future<List<User>> call({required int page, required int perPage, String? query}) {
    return repository.getUsers(page: page, perPage: perPage, query: query);
  }
}
