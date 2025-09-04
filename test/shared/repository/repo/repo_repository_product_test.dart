import 'package:flutter_test/flutter_test.dart';
import 'package:git_hub_repository_search_app/shared/data/git_hub_api_client.dart';
import 'package:git_hub_repository_search_app/shared/model/api_response.dart';
import 'package:git_hub_repository_search_app/shared/repository/repo/repo_repository_product.dart';
import 'package:mocktail/mocktail.dart';

class MockGitHubApiClient extends Mock implements GitHubApiClient {}

Map<String, dynamic> repoJson({
  required String name,
  required String ownerName,
}) {
  return {
    "name": name,
    "full_name": "$ownerName/$name",
    "owner": {"login": ownerName},
    "html_url": "https://github.com/opentween/OpenTween",
    "description": "flutter",
    "stargazers_count": 0,
    "watchers_count": 0,
    "language": "Dart",
    "forks_count": 0,
    "open_issues_count": 0,
  };
}

void main() {
  group("RepoRepositoryProduct.search", () {
    late MockGitHubApiClient mockClient;
    late RepoRepositoryProduct repository;

    setUp(() {
      mockClient = MockGitHubApiClient();
      repository = RepoRepositoryProduct(client: mockClient);
    });

    test("正常 次ページなし", () async {
      final body = {
        "items": [
          repoJson(name: "A", ownerName: "ABC"),
          repoJson(name: "B", ownerName: "BCD"),
        ],
      };
      final header = <String, dynamic>{};

      when(
        () => mockClient.searchRepositories(
          keyword: any(named: "keyword"),
          page: any(named: "page"),
          perPage: any(named: "perPage"),
        ),
      ).thenAnswer((_) async => ApiResponse(body: body, headers: header));

      final result = await repository.search(
        keyword: "abc",
        page: 2,
        perPage: 50,
      );

      expect(result.hasNextPage, isFalse);
      expect(result.repos, hasLength(2));
      verify(
        () =>
            mockClient.searchRepositories(keyword: "abc", page: 2, perPage: 50),
      ).called(1);
    });

    test("正常 次ページあり", () async {
      final body = {
        "items": [repoJson(name: "A", ownerName: "ABC")],
      };
      final header = {
        "link":
            '<https://api.github.com/search/repositories?q=%E3%81%9F%E3%81%8B&page=2&per_page=30>; rel="next",'
            '<https://api.github.com/search/repositories?q=%E3%81%9F%E3%81%8B&page=34&per_page=30>; rel="last"',
      };

      when(
        () => mockClient.searchRepositories(
          keyword: any(named: "keyword"),
          page: any(named: "page"),
          perPage: any(named: "perPage"),
        ),
      ).thenAnswer((_) async => ApiResponse(body: body, headers: header));

      final result = await repository.search(
        keyword: "abc",
        page: 2,
        perPage: 50,
      );

      expect(result.hasNextPage, isTrue);
      expect(result.repos, hasLength(1));
      verify(
        () =>
            mockClient.searchRepositories(keyword: "abc", page: 2, perPage: 50),
      ).called(1);
    });
    test("異常 itemsがListじゃない", () {
      final body = {
        "items": {"unexpected": "object"},
      };
      final headers = <String, String>{};

      when(
        () => mockClient.searchRepositories(
          keyword: any(named: "keyword"),
          page: any(named: "page"),
          perPage: any(named: "perPage"),
        ),
      ).thenAnswer((_) async => ApiResponse(body: body, headers: headers));

      expect(
        repository.search(keyword: "abc"),
        throwsA(
          predicate(
            (e) => e is Exception && e.toString().contains("JSONフォーマット不正"),
          ),
        ),
      );

      verify(() => mockClient.searchRepositories(keyword: "abc")).called(1);
    });
  });
}
