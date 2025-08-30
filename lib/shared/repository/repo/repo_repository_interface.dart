import 'package:git_hub_repository_search_app/shared/model/git_hub_repo_page.dart';

/// GitHubリポジトリのリポジトリ層のインターフェース
abstract class RepoRepositoryInterface {
  /// リポジトリ検索
  ///
  /// [keyword] 検索対象のキーワード
  /// [page] 対象のページ
  /// [perPage] ページ毎のリポジトリ数
  Future<GitHubRepoPage> search({
    required String keyword,
    int page = 1,
    int perPage = 30,
  });
}
