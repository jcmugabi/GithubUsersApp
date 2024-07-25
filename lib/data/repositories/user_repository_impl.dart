import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../models/github_user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final String baseUrl = 'https://api.github.com';

  @override
  Future<List<User>> getUsers(
      {required int page, required int perPage, String? query, String? filterType}) async {
    final typeFilter = (filterType != null && filterType != 'All')
        ? '+type:$filterType'
        : '';
    final response = await http.get(Uri.parse(
        '$baseUrl/search/users?q=location:$query&$typeFilter&page=$page&per_page=$perPage${query !=
            null ? '&q=$query' : ''}'));
    if (response.statusCode == 200) {
      final List<dynamic> items = json.decode(response.body)['items'];
      return items.map((item) => GithubUserModel.fromJson(item).toEntity())
          .toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  @override
  Future<User> getUserDetails(String username) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$username'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> userJson = json.decode(response.body);
      return GithubUserModel.fromJson(userJson).toEntity();
    } else {
      throw Exception('Failed to load user details');
    }
  }

  @override
  Future<List<User>> searchUsers(String query) async {
    final response = await http.get(
        Uri.parse('https://api.github.com/search/users?q=$query'));
    if (response.statusCode == 200) {
      final List<dynamic> items = json.decode(response.body)['items'];
      return items.map((item) => GithubUserModel.fromJson(item).toEntity())
          .toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}