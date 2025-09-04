import 'package:git_hub_repository_search_app/shared/data/git_hub_api_client.dart';
import 'package:git_hub_repository_search_app/shared/model/git_hub_repo.dart';
import 'package:git_hub_repository_search_app/shared/model/git_hub_repo_page.dart';
import 'package:git_hub_repository_search_app/shared/repository/repo/repo_repository_interface.dart';

/// 製品版のGitHubリポジトリのリポジトリ
class RepoRepositoryProduct implements RepoRepositoryInterface {
  RepoRepositoryProduct({GitHubApiClient? client})
    : client = client ?? GitHubApiClient();

  final GitHubApiClient client;

  @override
  Future<GitHubRepoPage> search({
    required String keyword,
    int page = 1,
    int perPage = 30,
  }) async {
    // TODO: try-catch検討
    final result = await client.searchRepositories(
      keyword: keyword,
      page: page,
      perPage: perPage,
    );
    // TODO: HTTPステータスコードが200以外の時は例外をスロー
    // リポジトリデータ作成
    final repoJsonList = result.body["items"];
    if (repoJsonList is! List) {
      // TODO: エラークラスを定義する
      throw Exception("JSONフォーマット不正");
    }
    final repos = repoJsonList
        .map((json) => GitHubRepo.fromJson(json))
        .toList();
    // 次ページがあるかどうか
    final link = result.headers["link"];
    final linkString = (link is String) ? link : null;
    final hasNextPage = linkString?.contains('rel="next"') ?? false;

    return GitHubRepoPage(repos: repos, hasNextPage: hasNextPage);
  }
}
