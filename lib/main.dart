import 'package:flutter/material.dart';
import 'package:git_hub_repository_search_app/search/view/page/search_page.dart';
import 'package:git_hub_repository_search_app/shared/repository/repo/repo_repository_interface.dart';
import 'package:git_hub_repository_search_app/shared/repository/repo/repo_repository_product.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // NOTE: 本当は[RepositoryProvider]を使用すべきだが、要求のためProviderを使用する
    return Provider<RepoRepositoryInterface>(
      create: (_) => RepoRepositoryProduct(),
      child: MaterialApp(
        title: 'GitHub Repository Search App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: SearchPage(),
      ),
    );
  }
}
