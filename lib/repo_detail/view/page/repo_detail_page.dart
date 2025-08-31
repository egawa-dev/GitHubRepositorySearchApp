import 'package:flutter/material.dart';
import 'package:git_hub_repository_search_app/shared/model/git_hub_repo.dart';

class RepoDetailPage extends StatelessWidget {
  const RepoDetailPage({super.key, required this.repo});

  final GitHubRepo repo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(repo.name)),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            _User(userName: repo.owner.name, iconUrl: repo.owner.iconUrl),
            SizedBox(height: 30),
            Expanded(child: _RepositoryMetadata(repo: repo)),
          ],
        ),
      ),
    );
  }
}

/// ユーザー情報
class _User extends StatelessWidget {
  const _User({super.key, required this.userName, this.iconUrl});

  /// ユーザーアイコンのURL
  final String? iconUrl;

  /// ユーザー名
  final String userName;

  @override
  Widget build(BuildContext context) {
    final url = iconUrl;
    return Row(
      children: [
        if (url != null)
          CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage(url),
            backgroundColor: Colors.transparent,
          ),
        SizedBox(width: 20),
        Text(userName),
      ],
    );
  }
}

/// リポジトリのメタデータ
class _RepositoryMetadata extends StatelessWidget {
  const _RepositoryMetadata({super.key, required this.repo});

  /// リポジトリ情報
  final GitHubRepo repo;

  @override
  Widget build(BuildContext context) {
    final language = repo.language;
    final starsCount = repo.starsCount?.toString();
    final watchersCount = repo.watchersCount?.toString();
    final forksCount = repo.forksCount?.toString();
    final issuesCount = repo.openIssuesCount?.toString();

    return ListView(
      children: [
        if (language != null) _tile("言語", language),
        if (language != null) Divider(),
        if (starsCount != null) _tile("スター数", starsCount),
        if (starsCount != null) Divider(),
        if (watchersCount != null) _tile("ウォッチャー数", watchersCount),
        if (watchersCount != null) Divider(),
        if (forksCount != null) _tile("フォーク数", forksCount),
        if (forksCount != null) Divider(),
        if (issuesCount != null) _tile("イシュー数", issuesCount),
      ],
    );
  }

  Widget _tile(String title, String data) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(title, style: TextStyle(fontSize: 16)),
        Spacer(),
        Text(data, style: TextStyle(fontSize: 16)),
      ],
    );
  }
}
