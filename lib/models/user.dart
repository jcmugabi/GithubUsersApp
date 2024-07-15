// lib/models/user.dart

class User {
  final String login;
  final String avatarUrl;

  User({required this.login, required this.avatarUrl});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      login: json['login'],
      avatarUrl: json['avatar_url'],
    );
  }
}

class UserDetails {
  final String login;
  final String avatarUrl;
  final String? name;
  final int followers;
  final int following;
  final String htmlUrl;
  final String? email;

  UserDetails({
    required this.login,
    required this.avatarUrl,
    this.name,
    required this.followers,
    required this.following,
    required this.htmlUrl,
    this.email,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      login: json['login'],
      avatarUrl: json['avatar_url'],
      name: json['name'],
      followers: json['followers'],
      following: json['following'],
      htmlUrl: json['html_url'],
      email: json['email'],
    );
  }
}
