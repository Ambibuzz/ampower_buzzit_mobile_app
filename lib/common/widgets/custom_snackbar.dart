import 'package:ampower_buzzit_mobile/util/constants/sizes.dart';
import 'package:flutter/material.dart';

// show custom snackbar
void showSnackBar(String text, BuildContext context,
    {Color? backgroundColor, Duration? duration}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text,
        style: TextStyle(fontSize: Sizes.fontSizeSubTitleWidget(context))),
    behavior: SnackBarBehavior.floating,
    backgroundColor:
        backgroundColor ?? Theme.of(context).snackBarTheme.backgroundColor,
    duration: duration ?? const Duration(seconds: Sizes.snackbarDuration),
    margin: const EdgeInsetsDirectional.symmetric(
        horizontal: Sizes.smallPadding, vertical: Sizes.smallPadding),
  ));
}