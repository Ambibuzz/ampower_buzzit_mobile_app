import 'package:ampower_buzzit_mobile/config/styles.dart';
import 'package:ampower_buzzit_mobile/util/constants/sizes.dart';
import 'package:ampower_buzzit_mobile/util/display_helper.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:fluttertoast/fluttertoast.dart';

//It displays toast message throughout the app

Future fluttertoast(Color textColor, Color backgroundColor, String message,
    BuildContext context) {
  return flutterStyledToast(
    context,
    message,
    backgroundColor,
    textStyle: TextStyle(
      color: textColor,
      fontSize: displayWidth(context) < 600
          ? Sizes.fontSizeMobile
          : Sizes.fontSizeLargeDevice,
    ),
  );
}

Future flutterSimpleToast(
    Color textColor, Color backgroundColor, String message) {
  return Fluttertoast.showToast(
      msg: message,
      textColor: textColor,
      backgroundColor: backgroundColor,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_LONG);
}

Future showErrorToast(Response<dynamic>? response) async {
  if (response?.data['message'] != null) {
    await flutterSimpleToast(
        Colors.white, Colors.black, response?.data['message']);
  } else {
    await flutterSimpleToast(Colors.white, Colors.black,
        'Something Went Wrong! Please re-login or contact support@ambibuzz.com');
  }
}

flutterStyledToast(BuildContext context, String message, Color backgroundColor,
    {TextStyle? textStyle}) {
  return showToast(message,
      backgroundColor: backgroundColor,
      context: context,
      textStyle: textStyle,
      animation: StyledToastAnimation.slideFromTop,
      borderRadius: Corners.lgBorder,
      textPadding: EdgeInsets.symmetric(
          horizontal: Sizes.paddingWidget(context),
          vertical: Sizes.paddingWidget(context)),
      // reverseAnimation: StyledToastAnimation.slideToTop,
      position: StyledToastPosition.bottom,
      // startOffset: const Offset(0.0, -3.0),
      // reverseEndOffset: const Offset(0.0, -3.0),
      duration: const Duration(seconds: 3),
      animDuration: const Duration(seconds: 1),
      curve: Curves.elasticOut,
      reverseCurve: Curves.fastOutSlowIn);
}
