import '../github_api_client.dart';
import '../models/github_user_model.dart';

// Service to fetch data from the GitHub API.
class GithubApiService {
  final GithubApiClient apiClient;

  GithubApiService({required this.apiClient});

  Future<List<GithubUserModel>> fetchUsers({required int page, required int perPage}) async {
    final response = await apiClient.fetchUsers(page, perPage);
    final items = response['items'] as List;

    return items.map((item) => GithubUserModel.fromJson(item)).toList();
  }

  Future<GithubUserModel> fetchUserDetails(String username) async {
    final response = await apiClient.fetchUserDetails(username);

    return GithubUserModel.fromJson(response);
  }


  Future<List<GithubUserModel>> searchUsers({required String query, required int page, required int perPage}) async {
    final response = await apiClient.searchUsers(query, page, perPage);
    final items = response['items'] as List;

    return items.map((item) => GithubUserModel.fromJson(item)).toList();
  }
}