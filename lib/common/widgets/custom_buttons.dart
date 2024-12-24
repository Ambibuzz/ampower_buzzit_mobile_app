import 'package:ampower_buzzit_mobile/util/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomButtons {
  static Widget textButton(
    String? buttonText,
    Color? buttonColor,
    void Function()? onPressed, {
    TextStyle? buttonTextStyle,
  }) {
    return TextButton(
      style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(buttonColor)),
      onPressed: onPressed,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: Sizes.extraSmallPadding),
        child: Text(
          buttonText ?? '',
          style: buttonTextStyle ?? const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
