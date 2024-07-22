import '../entities/user.dart';

abstract class UserRepository {
  Future<List<User>> getUsers({required int page, required int perPage, String? query, String? filterType});
  Future<User> getUserDetails(String username);
  Future<List<User>> filterUsersByType({required String type, required int page, required int perPage});
}
