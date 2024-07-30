import '../../domain/entities/user.dart';

class GithubUserModel {
  final String login;
  final String avatarUrl;
  final String name;
  final String followers;
  final String following;
  final String type;
  final String bio;

  GithubUserModel({
    required this.login,
    required this.avatarUrl,
    required this.name,
    required this.followers,
    required this.following,
    required this.type,
    required this.bio,
  });

  factory GithubUserModel.fromJson(Map<String, dynamic> json) {
    return GithubUserModel(
      login: json['login'],
      avatarUrl: json['avatar_url'],
      name: json['name'] ?? '',
      followers: json['followers'].toString(),
      following: json['following'].toString(),
      type: json['type'] ?? '',
      bio: json['bio'] ?? '',
    );
  }

  User toEntity() {
    return User(
      login: login,
      avatarUrl: avatarUrl,
      name: name,
      followers: followers,
      following: following,
      type: type,
      bio: bio,
    );
  }
}


