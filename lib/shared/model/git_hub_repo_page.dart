import 'package:git_hub_repository_search_app/shared/model/git_hub_repo.dart';

/// GitHubリポジトリの1ページ(WebAPIのレスポンス)
class GitHubRepoPage {
  GitHubRepoPage({required this.repos, required this.hasNextPage});

  final List<GitHubRepo> repos;
  final bool hasNextPage;
}
