import 'package:flutter/widgets.dart';

class TableData {
  final String value;
  final double width;
  final bool isBold;
  final Alignment? alignment;
  final TextAlign? textAlign;

  TableData({
    required this.value,
    required this.width,
    this.isBold = false,
    this.alignment,
    this.textAlign,
  });
}
