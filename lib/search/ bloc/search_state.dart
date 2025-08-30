import 'package:equatable/equatable.dart';

/// 検索画面状態の基底クラス
sealed class SearchState extends Equatable {}

/// 検索に成功した状態
class SearchSuccess extends SearchState {
  // TODO: 検索結果

  @override
  List<Object?> get props => [];
}
