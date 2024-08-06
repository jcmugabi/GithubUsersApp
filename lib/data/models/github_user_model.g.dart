// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'github_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GithubUserModel _$GithubUserModelFromJson(Map<String, dynamic> json) =>
    GithubUserModel(
      login: json['login'] as String,
      avatarUrl: json['avatar_url'] as String,
      name: json['name'] as String,
      followers: json['followers'] as String,
      following: json['following'] as String,
      type: json['type'] as String,
      bio: json['bio'] as String,
    );

Map<String, dynamic> _$GithubUserModelToJson(GithubUserModel instance) =>
    <String, dynamic>{
      'login': instance.login,
      'avatar_url': instance.avatarUrl,
      'name': instance.name,
      'followers': instance.followers,
      'following': instance.following,
      'type': instance.type,
      'bio': instance.bio,
    };
