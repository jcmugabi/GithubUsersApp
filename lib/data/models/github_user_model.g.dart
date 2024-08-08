// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'github_user_model.dart';

GithubUserModel _$GithubUserModelFromJson(Map<String, dynamic> json) =>
    GithubUserModel(
      login: json['login'] as String,
      avatarUrl: json['avatar_url'] as String?,
      name: json['name'] as String?,
      followers: (json['followers'] as num?)?.toInt(),
      following: (json['following'] as num?)?.toInt(),
      type: json['type'] as String?,
      bio: json['bio'] as String?,
    );
