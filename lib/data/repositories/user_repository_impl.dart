import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../models/github_user_model.dart';
import '../remote/api_data.dart';

class UserRepositoryImpl implements UserRepository {
  final ApiData apiData;

  UserRepositoryImpl(this.apiData);

  @override
  Future<List<User>> getUsers({
    required int page,
    required int perPage,
    String? query,
    String? filterType,
    String? location,
  }) async {
    final List<GithubUserModel> githubUsers = await apiData.fetchUsers(
      page: page,
      perPage: perPage,
      query: query,
      location: location,
    );
    return githubUsers.map((user) => user.toEntity()).toList();
  }

  @override
  Future<User> getUserDetails(String username) async {
    final GithubUserModel githubUser = await apiData.fetchUserDetails(username);
    return githubUser.toEntity();
  }
}
