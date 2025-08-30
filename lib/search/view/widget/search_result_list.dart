import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:git_hub_repository_search_app/search/%20bloc/search_bloc.dart';
import 'package:git_hub_repository_search_app/search/%20bloc/search_state.dart';
import 'package:git_hub_repository_search_app/search/view/widget/search_result_tile.dart';
import 'package:git_hub_repository_search_app/shared/model/git_hub_repo.dart';

/// 検索結果リスト
class SearchResultList extends StatelessWidget {
  const SearchResultList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        switch (state) {
          case SearchInitial():
            return _initialMessage();
          case SearchSuccess(:List<GitHubRepo> results):
            return ListView.builder(
              itemCount: 3, // TODO: APIで取得した結果数に合わせること
              itemBuilder: (context, index) {
                // TODO: 読み込み中の表示
                return SearchResultTile();
              },
            );
        }
      },
    );
  }

  // 初期状態のメッセージ
  Widget _initialMessage() {
    return Container(
      alignment: Alignment.topCenter,
      child: Text(
        "キーワードを入力して検索してください。",
        maxLines: 2,
        overflow: TextOverflow.fade,
      ),
    );
  }
}
