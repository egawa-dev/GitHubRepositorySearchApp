import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:git_hub_repository_search_app/shared/data/git_hub_api_client.dart';
import 'package:http/testing.dart';
import 'package:http/http.dart' as http;

void main() {
  group("GitHubApiClient.searchRepositories", () {
    // 以下の観点をテスト
    // ・searchRepositories関数の引数に指定した内容が使用されているか
    // ・正しいURLを使用しているか
    // ・想定通りの戻り値となっているか
    // ・モッククライアントに実装した内容が戻り値に反映されているか
    test("正常系", () async {
      final keyword = "flutter";
      final page = 3;
      final perPage = 50;

      final mock = MockClient((request) async {
        expect(request.method, "GET");
        // URL検
        expect(request.url.scheme, "https");
        expect(request.url.host, "api.github.com");
        expect(request.url.path, "/search/repositories");

        // クエリ検証
        expect(request.url.queryParameters["q"], keyword);
        expect(request.url.queryParameters["page"], page.toString());
        expect(request.url.queryParameters["per_page"], perPage.toString());

        // レスポンス
        final body = jsonEncode({"items": []});
        return http.Response(body, 200, headers: {"link": 'rel="next"'});
      });

      final api = GitHubApiClient(httpClient: mock);
      final res = await api.searchRepositories(
        keyword: keyword,
        page: page,
        perPage: perPage,
      );

      // 戻り値検証
      expect(res.body["items"], isA<List>());
      expect(res.headers["link"], 'rel="next"');
    });

    test("注入したhttpClientが使用されているか", () async {
      var used = false;

      final client = MockClient((request) async {
        used = true;

        // レスポンス
        final body = jsonEncode({"items": []});
        return http.Response(body, 200, headers: {"link": 'rel="next"'});
      });

      final api = GitHubApiClient(httpClient: client);
      final _ = await api.searchRepositories(keyword: "flutter");
      expect(used, isTrue, reason: "注入したClientが使用されていない");
    });

    test("キーワードのエンコードが正しく動作する(スペースや記号含み)", () async {
      final keyword = "test テスト:-";
      final mock = MockClient((request) async {
        expect(request.url.queryParameters["q"], keyword);

        // レスポンス
        final body = jsonEncode({"items": []});
        return http.Response(body, 200, headers: {"link": 'rel="next"'});
      });

      final api = GitHubApiClient(httpClient: mock);
      final res = await api.searchRepositories(keyword: keyword);

      // 戻り値検証
      expect(res.body["items"], isA<List>());
      expect(res.headers["link"], 'rel="next"');
    });

    // TODO: HTTPステータスコードが200以外の時のテスト(未実装のため、実装後テスト準備)
  });
}
