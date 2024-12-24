import 'package:ampower_buzzit_mobile/util/constants/sizes.dart';
import 'package:flutter/material.dart';

class TypeAheadWidgets {
  static Widget itemUi(String item, BuildContext context, {Color? textColor}) {
    return ListTile(
      key: Key(item),
      title: Text(
        item,
        style: TextStyle(
          fontSize: Sizes.fontSizeWidget(context),
          color: textColor,
        ),
      ),
    );
  }

  static List<String> getSuggestions(String query, List<String> list) {
    var matches = <String>[];
    matches.addAll(list);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}
