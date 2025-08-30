import 'package:flutter/material.dart';
import 'package:git_hub_repository_search_app/search/view/widget/search_result_tile.dart';

/// 検索結果リスト
class SearchResultList extends StatelessWidget {
  const SearchResultList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3, // TODO: APIで取得した結果数に合わせること
      itemBuilder: (context, index) {
        // TODO: 読み込み中の表示
        return SearchResultTile();
      },
    );
  }
}
