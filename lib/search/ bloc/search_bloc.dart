import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:git_hub_repository_search_app/search/%20bloc/search_event.dart';
import 'package:git_hub_repository_search_app/search/%20bloc/search_state.dart';

/// 検索画面のBLoC
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchSuccess()) {
    on<SearchPressedSearchButton>(_onPressedSearchButton);
  }

  /// 検索ボタンが押された時の処理
  Future<void> _onPressedSearchButton(
    SearchPressedSearchButton event,
    Emitter<SearchState> emit,
  ) async {
    print("検索ボタンが押されました"); // TODO: デバッグ用なので、処理実装が削除すること
    // TODO: 検索処理
  }
}
