/// 検索画面イベントの基底クラス
abstract class SearchEvent {}

/// 検索ボタンが押された時のイベント
class SearchPressedSearchButton extends SearchEvent {
  SearchPressedSearchButton({required this.keyword});

  /// 検索ボタンが押された時に入力されていた検索キーワード
  final String keyword;
}

/// 検索結果のリストビューが次ページを取得する位置までスクロールされた時のイベント
class SearchScrollNextPagePosition extends SearchEvent {}
