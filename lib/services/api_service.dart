// lib/services/api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class ApiService {
  static const String _baseUrl = 'https://api.github.com/search/users?q=location:uganda';

  Future<List<User>> fetchUsers({int page = 1, int perPage = 10}) async {
    final response = await http.get(Uri.parse('$_baseUrl&per_page=$perPage&page=$page'));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      List<dynamic> itemsJson = jsonResponse['items'];
      List<User> users = itemsJson.map((dynamic item) => User.fromJson(item)).toList();
      return users;
    } else {
      throw Exception('Failed to load users');
    }
  }
}
