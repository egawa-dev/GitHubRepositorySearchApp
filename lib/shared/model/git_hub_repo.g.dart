// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'git_hub_repo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GitHubRepo _$GitHubRepoFromJson(Map<String, dynamic> json) => GitHubRepo(
  name: json['full_name'] as String,
  url: json['html_url'] as String,
  owner: GitHubOwner.fromJson(json['owner'] as Map<String, dynamic>),
  description: json['description'] as String?,
  language: json['language'] as String?,
  starsCount: (json['stargazers_cont'] as num?)?.toInt(),
  watchersCount: (json['watchers_count'] as num?)?.toInt(),
  forksCount: (json['forks_count'] as num?)?.toInt(),
  openIssuesCount: (json['open_issues_count'] as num?)?.toInt(),
);

Map<String, dynamic> _$GitHubRepoToJson(GitHubRepo instance) =>
    <String, dynamic>{
      'full_name': instance.name,
      'html_url': instance.url,
      'owner': instance.owner,
      'description': instance.description,
      'language': instance.language,
      'stargazers_cont': instance.starsCount,
      'watchers_count': instance.watchersCount,
      'forks_count': instance.forksCount,
      'open_issues_count': instance.openIssuesCount,
    };
