import '../../domain/entities/user.dart';

// Data model representing user data as received from the GitHub API.
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

  // Factory method to create a GithubUserModel from JSON.
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

  // Converts this model to a User entity.
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


