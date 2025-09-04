import 'dart:convert';

import 'package:git_hub_repository_search_app/shared/model/api_response.dart';
import 'package:http/http.dart' as http;

/// GitHubAPIのクライアント
class GitHubApiClient {
  // NOTE: テストを容易にするために、http.Clientを外部から注入できるようにする
  GitHubApiClient({http.Client? httpClient})
    : httpClient = httpClient ?? http.Client();

  final http.Client httpClient;

  /// リポジトリ検索API
  ///
  /// [ドキュメント](https://docs.github.com/ja/rest/search/search?apiVersion=2022-11-28#search-repositories)
  Future<ApiResponse> searchRepositories({
    required String keyword,
    int page = 1,
    int perPage = 30,
  }) async {
    // TODO: perPageが1以上100までしか許可されてないためチェックが必要
    // TODO: pageは1以上でないといけないためチェックが必要
    // TODO: 検索キーワードの前後空白を trim、空なら早期 return/例外

    // TODO: 不正な文字対策でtry-catch必要
    final url = Uri.https("api.github.com", "/search/repositories", {
      "q": keyword,
      "page": page.toString(),
      "per_page": perPage.toString(),
    });

    // TODO: ヘッダーにUser-Agentを指定(アプリ名でいいかも)
    // TODO: ヘッダーに「Accept: application/vnd.github+json」を指定
    // TODO: ヘッダーに「X-GitHub-Api-Version: 2022-11-28」を指定
    // NOTE: 認証情報を入れることで、APIの制限を緩和できるが、機密情報の管理が難しくなるため、今回は使用しません。

    // TODO: インターネット未接続時を考慮してtry-catch必要
    // TODO: ハングアウト対策でタイムアウトを設定する
    final response = await httpClient.get(url);

    if (response.statusCode == 200) {
      // NOTE: 外部パッケージに依存しているクラスを使うとパッケージを変更したときに影響が大きいため、ApiResponseを定義して影響を小さくする
      return ApiResponse(
        body: jsonDecode(utf8.decode(response.bodyBytes)),
        headers: response.headers,
      );
    } else {
      // TODO: あとで詳細なエラー処理実装
      // TODO: エラー時のステータスコードを例外に添付しても良いかも
      throw Exception();
    }
  }
}
