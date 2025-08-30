import 'package:flutter/material.dart';

/// キーワード入力フィールド
class InputKeywordField extends StatelessWidget {
  const InputKeywordField({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: TextField()),
        OutlinedButton(
          onPressed: () {
            // TODO: BLoCにイベント送信
          },
          child: Text("検索"),
        ),
      ],
    );
  }
}
