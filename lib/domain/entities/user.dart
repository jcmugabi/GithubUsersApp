class User {
  final String login;
  final String? avatarUrl;
  final String? name;
  final int? followers;
  final int? following;
  final String? type;
  final String? bio;


  User({
    required this.login,
    required this.avatarUrl,
    required this.name,
    required this.followers,
    required this.following,
    required this.type,
    required this.bio,
  });
}
