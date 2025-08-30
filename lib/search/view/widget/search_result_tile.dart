import 'package:flutter/material.dart';

/// 検索結果リストのタイル
class SearchResultTile extends StatelessWidget {
  const SearchResultTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text("リポジトリー名"),
        trailing: Icon(Icons.arrow_forward_ios, size: 12),
        onTap: () {
          // TODO: 詳細画面に遷移
        },
      ),
    );
  }
}
