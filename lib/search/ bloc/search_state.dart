import 'package:equatable/equatable.dart';
import 'package:git_hub_repository_search_app/shared/model/git_hub_repo.dart';

/// 検索画面状態の基底クラス
sealed class SearchState extends Equatable {
  @override
  List<Object?> get props => [];
}

/// 初期状態
class SearchInitial extends SearchState {}

/// 初回データ読み込み中状態
class SearchInitialLoading extends SearchState {}

/// 追加データ読み込み中状態
class SearchAddLoading extends SearchState {
  final List<GitHubRepo> results;

  SearchAddLoading(this.results);

  @override
  List<Object?> get props => [results];
}

/// 検索に成功した状態
class SearchSuccess extends SearchState {
  SearchSuccess({required this.results, required this.hasNextPage});

  /// 検索結果
  final List<GitHubRepo> results;

  /// 次のページがあるか
  /// NOTE: GitHubAPIがページごとに取得する仕様のため必要
  final bool hasNextPage;

  @override
  List<Object?> get props => [results, hasNextPage];
}

/// 検索が失敗した状態
class SearchFailure extends SearchState {
  final String error;

  SearchFailure(this.error);

  @override
  List<Object?> get props => [error];
}
