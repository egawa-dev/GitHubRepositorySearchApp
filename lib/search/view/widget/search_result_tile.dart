import 'package:flutter/material.dart';
import 'package:git_hub_repository_search_app/repo_detail/view/page/repo_detail_page.dart';
import 'package:git_hub_repository_search_app/shared/model/git_hub_repo.dart';

/// 検索結果リストのタイル
class SearchResultTile extends StatelessWidget {
  const SearchResultTile({super.key, required this.repo});

  /// リポジトリ情報
  final GitHubRepo repo;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(repo.name),
        trailing: Icon(Icons.arrow_forward_ios, size: 12),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => RepoDetailPage(repo: repo)),
          );
        },
      ),
    );
  }
}
