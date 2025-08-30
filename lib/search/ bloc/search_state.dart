import 'package:equatable/equatable.dart';
import 'package:git_hub_repository_search_app/shared/model/git_hub_repo.dart';

/// 検索画面状態の基底クラス
sealed class SearchState extends Equatable {}

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
