import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:git_hub_repository_search_app/search/%20bloc/search_event.dart';
import 'package:git_hub_repository_search_app/search/%20bloc/search_state.dart';
import 'package:git_hub_repository_search_app/shared/repository/repo/repo_repository_interface.dart';

/// 検索画面のBLoC
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({required this.repoRepository}) : super(SearchInitial()) {
    on<SearchPressedSearchButton>(_onPressedSearchButton);
    on<SearchScrollNextPagePosition>(_onScrollNextPagePosition);
  }

  final RepoRepositoryInterface repoRepository;

  /// 現在のページ
  int _currentPage = 0;

  /// 現在の検索キーワード
  String _searchKeyword = "";

  /// 検索ボタンが押された時の処理
  Future<void> _onPressedSearchButton(
    SearchPressedSearchButton event,
    Emitter<SearchState> emit,
  ) async {
    // NOTE: 初回読み込み中状態の際は実行しない
    if (state is SearchInitialLoading) {
      return;
    }

    emit(SearchInitialLoading());

    try {
      // NOTE: 次ページを読み込むために保存
      _searchKeyword = event.keyword;
      final results = await repoRepository.search(keyword: event.keyword);
      if (results.repos.isEmpty) {
        emit(SearchSuccessEmpty());
        return;
      }
      _currentPage = 1;
      emit(
        SearchSuccess(results: results.repos, hasNextPage: results.hasNextPage),
      );
    } catch (_) {
      emit(SearchFailure("検索に失敗しました。"));
    }
  }

  Future<void> _onScrollNextPagePosition(
    SearchScrollNextPagePosition event,
    Emitter<SearchState> emit,
  ) async {
    // NOTE: 以降の処理でスマートキャストされるためにローカル変数にする必要がある
    final beforeState = state; // 処理前の状態
    // 検索成功状態のみ処理する
    if (beforeState is! SearchSuccess) {
      return;
    }
    // 次のページが存在する場合のみ処理する
    if (!beforeState.hasNextPage) {
      return;
    }

    // 追加データ読み込み状態に移行
    emit(SearchAddLoading(beforeState.results));

    try {
      // 検索APIを実行
      final nextResults = await repoRepository.search(
        keyword: _searchKeyword,
        page: _currentPage + 1,
      );
      // NOTE: 以降の処理でスマートキャストされるためにローカル変数にする必要がある
      final afterState = state; // 処理後の状態
      if (afterState is SearchAddLoading) {
        emit(
          SearchSuccess(
            results: [...afterState.results, ...nextResults.repos],
            hasNextPage: nextResults.hasNextPage,
          ),
        );
      } else if (afterState is SearchSuccess) {
        // NOTE: 基本的にありえないが、非同期処理待機後なので念の為ケアしておく
        emit(
          SearchSuccess(
            results: [...afterState.results, ...nextResults.repos],
            hasNextPage: nextResults.hasNextPage,
          ),
        );
      } else {
        // NOTE: 基本的にありえないが、非同期処理待機後なので念の為ケアしておく
        emit(
          SearchSuccess(
            results: nextResults.repos,
            hasNextPage: nextResults.hasNextPage,
          ),
        );
      }
      _currentPage += 1;
    } catch (_) {
      // NOTE: 以降の処理でスマートキャストされるためにローカル変数にする必要がある
      final stateAfterError = state; // エラー後の状態
      if (stateAfterError is SearchAddLoading) {
        // NOTE: 次ページを読み込もうとして失敗したので、次ページはまだある
        emit(
          SearchSuccess(results: stateAfterError.results, hasNextPage: true),
        );
      } else if (stateAfterError is SearchSuccess) {
        // NOTE: 基本的にありえないが、非同期処理待機後なので念の為ケアしておく
        // NOTE: 次ページを読み込もうとして失敗したので、次ページはまだある
        emit(
          SearchSuccess(results: stateAfterError.results, hasNextPage: true),
        );
      } else {
        // NOTE: 基本的にありえないが、非同期処理待機後なので念の為ケアしておく
        // NOTE: 前回のデータがわからないので、エラー画面にする
        emit(SearchFailure("検索に失敗しました。"));
      }
    }
  }
}
