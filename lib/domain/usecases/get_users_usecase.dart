import '../../injector.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class GetUsersUseCase {
  final UserRepository repository = injector<UserRepository>();

  Future<List<User>> call({
    required int page,
    required int perPage,
    String? query,
    String? filterType,
    String? location,
  }) async {
    return await repository.getUsers(
      page: page,
      perPage: perPage,
      query: query,
      filterType: filterType,
      location: location,
    );
  }
}
