import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:git_hub_repository_search_app/search/%20bloc/search_bloc.dart';
import 'package:git_hub_repository_search_app/search/%20bloc/search_event.dart';

/// キーワード入力フィールド
class InputKeywordField extends StatefulWidget {
  const InputKeywordField({super.key});

  @override
  State<InputKeywordField> createState() => _InputKeywordFieldState();
}

class _InputKeywordFieldState extends State<InputKeywordField> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: TextField(controller: _controller)),
        OutlinedButton(
          onPressed: () {
            context.read<SearchBloc>().add(
              SearchPressedSearchButton(keyword: _controller.text),
            );
          },
          child: Text("検索"),
        ),
      ],
    );
  }
}
