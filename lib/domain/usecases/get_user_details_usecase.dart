import '../../injector.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';


class GetUserDetailsUseCase {

  final UserRepository repository = injector<UserRepository>();

  Future<User> call(String username) {
    return repository.getUserDetails(username);
  }
}
