class User {
  final String login; //user's user name
  final String avatarUrl;//url to user's avatar image
  final String name;
  final String followers;
  final String following;
  final String type;
  final String bio;

  //initialisation
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
