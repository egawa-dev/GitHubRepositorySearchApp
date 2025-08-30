import 'package:git_hub_repository_search_app/shared/model/git_hub_owner.dart';
import 'package:json_annotation/json_annotation.dart';
part 'git_hub_repo.g.dart';

/// GitHubのリポジトリ
///
/// NOTE: "Repository"という命名にするとRepository層と紛らわしいため、"Repo"と命名する。
@JsonSerializable()
class GitHubRepo {
  GitHubRepo({
    required this.name,
    required this.url,
    required this.owner,
    this.description,
    this.language,
    this.starsCount,
    this.watchersCount,
    this.forksCount,
    this.openIssuesCount,
  });

  /// リポジトリ名
  @JsonKey(name: "full_name")
  final String name;

  /// URL
  @JsonKey(name: "html_url")
  final String url;

  /// オーナー
  final GitHubOwner owner;

  /// 説明
  @JsonKey(name: "description")
  final String? description;

  /// 言語
  @JsonKey(name: "language")
  final String? language;

  ///スター数
  @JsonKey(name: "stargazers_cont")
  final int? starsCount;

  /// ウォッチャー数
  @JsonKey(name: "watchers_count")
  final int? watchersCount;

  /// フォーク数
  @JsonKey(name: "forks_count")
  final int? forksCount;

  /// 現在オープンになっているイシュー数
  @JsonKey(name: "open_issues_count")
  final int? openIssuesCount;

  factory GitHubRepo.fromJson(Map<String, dynamic> json) =>
      _$GitHubRepoFromJson(json);

  Map<String, dynamic> toJson() => _$GitHubRepoToJson(this);
}
