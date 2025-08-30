import 'package:git_hub_repository_search_app/shared/model/git_hub_repo_page.dart';

abstract class RepoRepositoryInterface {
  Future<GitHubRepoPage> search({
    required String keyword,
    int page = 1,
    int perPage = 30,
  });
}
