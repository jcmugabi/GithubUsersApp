import '../entities/user.dart';

abstract class UserRepository {
  Future<List<User>> getUsers({required int page, required int perPage, String? query});
  Future<User> getUserDetails(String username);
}
