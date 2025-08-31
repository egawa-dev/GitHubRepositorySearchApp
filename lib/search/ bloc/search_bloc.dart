import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:git_hub_repository_search_app/search/%20bloc/search_event.dart';
import 'package:git_hub_repository_search_app/search/%20bloc/search_state.dart';
import 'package:git_hub_repository_search_app/shared/repository/repo/repo_repository_interface.dart';

/// 検索画面のBLoC
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({required this.repoRepository}) : super(SearchInitial()) {
    on<SearchPressedSearchButton>(_onPressedSearchButton);
  }

  final RepoRepositoryInterface repoRepository;

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
      final results = await repoRepository.search(keyword: event.keyword);
      emit(
        SearchSuccess(results: results.repos, hasNextPage: results.hasNextPage),
      );
    } catch (_) {
      emit(SearchFailure("検索に失敗しました。"));
    }
  }
}
