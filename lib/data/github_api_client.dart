import 'package:http/http.dart' as http;
import 'dart:convert';

// Class to handle raw HTTP requests to the GitHub API.
class GithubApiClient {
  final String baseUrl;

  GithubApiClient({required this.baseUrl});

  // Method to perform GET request.
  Future<Map<String, dynamic>> fetchUsers(int page, int perPage) async {
    final response = await http.get(Uri.parse('$baseUrl/search/users?q=location:uganda&page=$page&per_page=$perPage'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<Map<String, dynamic>> fetchUserDetails(String username) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$username'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load user details');
    }
  }
}
