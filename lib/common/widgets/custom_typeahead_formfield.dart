import 'dart:async';

import 'package:ampower_buzzit_mobile/config/theme.dart';
import 'package:ampower_buzzit_mobile/util/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class CustomTypeAheadFormField extends StatelessWidget {
  const CustomTypeAheadFormField({
    Key? key,
    this.autoFlipDirection = true,
    required this.label,
    this.labelStyle,
    this.required = false,
    this.hideSuggestionOnKeyboardHide = false,
    this.controller,
    this.focusNode,
    this.onEditingComplete,
    required this.decoration,
    this.keyboardType = TextInputType.text,
    this.padding = EdgeInsets.zero,
    this.style,
    this.textInputAction = TextInputAction.next,
    this.validator,
    required this.onSuggestionSelected,
    required this.itemBuilder,
    required this.suggestionsCallback,
    this.transitionBuilder,
  }) : super(key: key);
  final String? label;
  final TextStyle? labelStyle;
  final bool? required;
  final bool hideSuggestionOnKeyboardHide;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function()? onEditingComplete;
  final InputDecoration decoration;
  final TextInputType keyboardType;
  final EdgeInsetsGeometry padding;
  final TextStyle? style;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final void Function(dynamic) onSuggestionSelected;
  final Widget Function(BuildContext, dynamic) itemBuilder;
  final FutureOr<List<dynamic>?> Function(String) suggestionsCallback;
  final Widget Function(BuildContext, Animation<double>, Widget)?
      transitionBuilder;
  final bool autoFlipDirection;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        children: [
          SizedBox(
            height: Sizes.buttonHeightWidget(context),
            child: TypeAheadField(
              controller: controller,
              autoFlipDirection: autoFlipDirection,
              builder: (context, controller, focusNode) {
                return TextField(
                  keyboardType: keyboardType,
                  style: style,
                  controller: controller,
                  focusNode: focusNode,
                  decoration: decoration.copyWith(
                    suffixIcon: GestureDetector(
                        onTap: () {
                          controller.clear();
                          focusNode.unfocus();
                        },
                        child: Icon(
                          Icons.clear,
                          size: 20,
                          color: CustomTheme.borderColor,
                        )),
                    label: Text(
                      label ?? '',
                      style: Sizes.textAndLabelStyle(context)?.copyWith(
                        color: CustomTheme.iconColor,
                      ),
                    ),
                  ),
                );
              },
              hideWithKeyboard: hideSuggestionOnKeyboardHide,
              onSelected: onSuggestionSelected,
              itemBuilder: itemBuilder,
              suggestionsCallback: suggestionsCallback,
              transitionBuilder: transitionBuilder,
              hideOnSelect: true,
              hideOnUnfocus: true,
            ),
          ),
        ],
      ),
    );
  }
}
