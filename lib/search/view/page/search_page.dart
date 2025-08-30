import 'package:flutter/material.dart';
import 'package:git_hub_repository_search_app/search/view/widget/input_keyword_field.dart';
import 'package:git_hub_repository_search_app/search/view/widget/search_result_list.dart';

/// 検索画面
class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("検索")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            InputKeywordField(),
            SizedBox(height: 20),
            Expanded(child: SearchResultList()),
          ],
        ),
      ),
    );
  }
}
