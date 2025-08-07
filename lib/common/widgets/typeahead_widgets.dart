import 'package:ampower_buzzit_mobile/util/constants/sizes.dart';
import 'package:ampower_buzzit_mobile/util/display_helper.dart';
import 'package:flutter/material.dart';

class TypeAheadWidgets {
  static Widget itemUi(String item, BuildContext context, {Color? textColor}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: Sizes.smallPaddingWidget(context) * 1.5,
            horizontal: displayWidth(context) < 600 ? 16 : 24,
          ),
          child: Text(
            key: Key(item),
            item,
            style: Sizes.subTitleTextStyle(context)?.copyWith(
              color: textColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  static List<String> getSuggestions(String query, List<String> list) {
    var matches = <String>[];
    matches.addAll(list);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}
