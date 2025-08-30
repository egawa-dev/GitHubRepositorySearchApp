// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'git_hub_owner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GitHubOwner _$GitHubOwnerFromJson(Map<String, dynamic> json) => GitHubOwner(
  name: json['login'] as String? ?? "",
  iconUrl: json['avatar_url'] as String?,
);

Map<String, dynamic> _$GitHubOwnerToJson(GitHubOwner instance) =>
    <String, dynamic>{'login': instance.name, 'avatar_url': instance.iconUrl};
