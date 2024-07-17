import '../../domain/entities/user.dart';

class GithubUserModel {
  final String login;
  final String avatarUrl;

  GithubUserModel({
    required this.login,
    required this.avatarUrl,
  });

  factory GithubUserModel.fromJson(Map<String, dynamic> json) {
    return GithubUserModel(
      login: json['login'],
      avatarUrl: json['avatar_url'],
    );
  }

  User toEntity() {
    return User(
      login: login,
      avatarUrl: avatarUrl,
    );
  }
}


