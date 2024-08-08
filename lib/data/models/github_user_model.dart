// import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/user.dart';

part 'github_user_model.g.dart';

@JsonSerializable()
class GithubUserModel extends User {
  final String login;
  final String? avatarUrl;
  final String? name;
  final int? followers;
  final int? following;
  final String? type;
  final String? bio;

  GithubUserModel({
    required this.login,
    this.avatarUrl,
    this.name,
    this.followers,
    this.following,
    this.type,
    this.bio,
  }) : super(
            login: '',
            avatarUrl: '',
            name: '',
            followers: 0,
            following: 0,
            type: '',
            bio: '');

  factory GithubUserModel.fromJson(Map<String, dynamic> json) =>
      _$GithubUserModelFromJson(json);

  User toEntity() {
    return User(
      login: login,
      avatarUrl: avatarUrl ?? '',
      name: name ?? '',
      followers: followers ?? 0,
      following: following ?? 0,
      type: type ?? '',
      bio: bio ?? '',
    );
  }
}
