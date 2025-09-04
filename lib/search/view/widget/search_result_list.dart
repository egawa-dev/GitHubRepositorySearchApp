import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:git_hub_repository_search_app/search/%20bloc/search_bloc.dart';
import 'package:git_hub_repository_search_app/search/%20bloc/search_event.dart';
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
          case SearchInitialLoading():
            return _searchingIndicator();
          case SearchAddLoading(:List<GitHubRepo> results):
            return _SearchResultListView(results: results, isLoading: true);
          case SearchSuccessEmpty():
            return _noResultsMessage();
          case SearchSuccess(:List<GitHubRepo> results):
            return _SearchResultListView(results: results, isLoading: false);
          case SearchFailure():
            return _errorMessage();
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

  // 検索中のインジケーター
  Widget _searchingIndicator() {
    return const Center(child: CircularProgressIndicator());
  }

  // 検索結果が見つからなかった場合のメッセージ
  Widget _noResultsMessage() {
    return Container(
      alignment: Alignment.topCenter,
      child: Text("検索結果が見つかりませんでした。", maxLines: 2, overflow: TextOverflow.fade),
    );
  }

  // 検索処理がエラーになった場合のメッセージ
  Widget _errorMessage() {
    return Container(
      alignment: Alignment.topCenter,
      child: Text("検索に失敗しました。", maxLines: 2, overflow: TextOverflow.fade),
    );
  }
}

class _SearchResultListView extends StatefulWidget {
  const _SearchResultListView({
    super.key,
    required this.results,
    this.isLoading = false,
  });

  final List<GitHubRepo> results;
  final bool isLoading;

  @override
  State<_SearchResultListView> createState() => _SearchResultListViewState();
}

class _SearchResultListViewState extends State<_SearchResultListView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    final results = widget.results;
    return ListView.builder(
      controller: _scrollController,
      itemCount: widget.isLoading ? (results.length + 1) : results.length,
      itemBuilder: (context, index) {
        if (index >= results.length) {
          return _indicator();
        }
        return SearchResultTile(repo: results[index]);
      },
    );
  }

  Widget _indicator() {
    return Row(
      children: [
        Spacer(),
        Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          width: 40,
          height: 40,
          child: CircularProgressIndicator(),
        ),
        Spacer(),
      ],
    );
  }

  void _onScroll() {
    // NOTE: 少し早めに次のページを読み込みたいので、50pixel分早いポジションにする
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 50) {
      context.read<SearchBloc>().add(SearchScrollNextPagePosition());
    }
  }
}
