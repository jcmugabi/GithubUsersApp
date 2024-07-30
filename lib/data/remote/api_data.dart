import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/github_user_model.dart';
import 'api_constants.dart';

class ApiData {

  Future<List<GithubUserModel>> fetchUsers({
    required int page,
    required int perPage,
    String? query,
    String? location,
  }) async {
    String url;
    if (query != null && location != null) {
      url = '${ApiUrls.baseUrl}/search/users?q=$query+location:$location&page=$page&per_page=$perPage';
    } else if (query == null && location == null) {
      url = '${ApiUrls.baseUrl}/search/users?q=$query+location:$location&page=$page&per_page=$perPage';
    } else if (query != null) {
      url = '${ApiUrls.baseUrl}/search/users?q=$query&page=$page&per_page=$perPage';
    } else if (location != null) {
      url = '${ApiUrls.baseUrl}/search/users?q=location:$location&page=$page&per_page=$perPage';
    } else {
      url = '${ApiUrls.baseUrl}/search/users?q=&page=$page&per_page=$perPage';
    }

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> items = json.decode(response.body)['items'];
      return items.map((item) => GithubUserModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<GithubUserModel> fetchUserDetails(String username) async {
    final response = await http.get(Uri.parse('${ApiUrls.baseUrl}/users/$username'));
    if (response.statusCode == 200) {
      final dynamic item = json.decode(response.body);
      return GithubUserModel.fromJson(item);
    } else {
      throw Exception('Failed to load user details');
    }
  }
}
