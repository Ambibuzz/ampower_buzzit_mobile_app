import 'package:ampower_buzzit_mobile/config/styles.dart';
import 'package:ampower_buzzit_mobile/config/theme.dart';
import 'package:ampower_buzzit_mobile/util/constants/sizes.dart';
import 'package:ampower_buzzit_mobile/util/display_helper.dart';
import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({
    Key? key,
    this.alignment = CrossAxisAlignment.center,
    this.label,
    this.required,
    this.labelStyle,
    this.onChanged,
    this.value,
    this.elevation = 1,
    this.focusNode,
    this.dropdownColor,
    this.focusColor,
    this.hint,
    this.icon,
    this.iconDisabledColor,
    this.iconEnabledColor,
    this.iconSize = 25,
    this.items,
    this.margin = EdgeInsets.zero,
    this.padding = const EdgeInsets.symmetric(
        horizontal: Sizes.horizontalSmallPadding * 1.25,
        vertical: Sizes.verticalSmallPadding * 0.25),
    this.width,
  }) : super(key: key);
  final String? label;
  final bool? required;
  final TextStyle? labelStyle;
  final void Function(String?)? onChanged;
  final String? value;
  final int elevation;
  final FocusNode? focusNode;
  final Color? dropdownColor;
  final Color? focusColor;
  final Widget? hint;
  final Widget? icon;
  final Color? iconDisabledColor;
  final Color? iconEnabledColor;
  final double iconSize;
  final List<DropdownMenuItem<String>>? items;
  final CrossAxisAlignment alignment;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry padding;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignment,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: Corners.lgBorder,
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          margin: margin,
          width: width ?? displayWidth(context),
          height: Sizes.buttonHeightWidget(context),
          child: Padding(
            padding: padding,
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: value,
                elevation: elevation,
                onChanged: onChanged,
                focusNode: focusNode,
                dropdownColor: dropdownColor,
                focusColor: focusColor,
                hint: hint,
                icon: icon,
                iconDisabledColor: iconDisabledColor,
                iconEnabledColor: iconEnabledColor,
                iconSize: iconSize,
                items: items,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
