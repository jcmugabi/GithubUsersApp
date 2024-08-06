// import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/user.dart';

part 'github_user_model.g.dart';

@JsonSerializable()
class GithubUserModel {
  final String login;

  @JsonKey(name: "avatar_url")
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

  factory GithubUserModel.fromJson(Map<String, dynamic> json) => _$GithubUserModelFromJson(json);

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


