import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../domain/entities/user.dart';
import '../../../domain/repositories/user_repository.dart';
import '../models/github_user_model.dart';

class UserRepositoryImpl implements UserRepository {
  static const String baseUrl = 'https://api.github.com';

  @override
  Future<List<User>> getUsers({
    required int page,
    required int perPage,
    String? query,
    String? filterType,
    String? location,
  }) async {
    // final typeFilter = (filterType != null && filterType != 'All') ? '+type:$filterType' : '';

    final queryString = query != null ? 'q=$query' : '';
    final locationString = location != null ? 'location:$location' : '';
    // final queryString = query != null ? 'q=$query' : "q=''";
    // final locationString = location != null ? 'location:$location' : "location:''";

    // String url;
    // if (query == null && location == null) {
    //   url = '$baseUrl/search/users?$queryString+$locationString&page=$page&per_page=$perPage';
    // } else if (query != null) {
    //   url = '$baseUrl/search/users?$queryString&page=$page&per_page=$perPage';
    // } else if (location != null) {
    //   url = '$baseUrl/search/users?q=$locationString&page=$page&per_page=$perPage';
    // } else {
    //   url = '$baseUrl/search/users?q=&page=$page&per_page=$perPage';
    // }

    String url;
    if (query != null && location != null) {
      url = '$baseUrl/search/users?q=$query+location:$location&page=$page&per_page=$perPage';
    }
    else if (query == null && location == null) {
      url = '$baseUrl/search/users?q=$query+location:$location&page=$page&per_page=$perPage';
    }
    else if (query != null) {
      url = '$baseUrl/search/users?q=$query&page=$page&per_page=$perPage';
    } else if (location != null) {
      url = '$baseUrl/search/users?q=location:$location&page=$page&per_page=$perPage';
    } else {
      url = '$baseUrl/search/users?q=&page=$page&per_page=$perPage';
    }

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> items = json.decode(response.body)['items'];
      return items.map((item) => GithubUserModel.fromJson(item).toEntity()).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  @override
  Future<User> getUserDetails(String username) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$username'));

    if (response.statusCode == 200) {
      final dynamic item = json.decode(response.body);
      return GithubUserModel.fromJson(item).toEntity();
    } else {
      throw Exception('Failed to load user details');
    }
  }
}
