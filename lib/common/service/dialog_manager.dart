import 'package:ampower_buzzit_mobile/common/model/alert_request.dart';
import 'package:ampower_buzzit_mobile/common/model/alert_response.dart';
import 'package:ampower_buzzit_mobile/common/service/dialog_service.dart';
import 'package:ampower_buzzit_mobile/locator/locator.dart';
import 'package:ampower_buzzit_mobile/util/constants/sizes.dart';
import 'package:ampower_buzzit_mobile/util/display_helper.dart';

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class DialogManager extends StatefulWidget {
  final Widget? child;
  const DialogManager({Key? key, required this.child}) : super(key: key);

  @override
  DialogManagerState createState() => DialogManagerState();
}

class DialogManagerState extends State<DialogManager> {
  DialogService dialogService = locator.get<DialogService>();

  @override
  void initState() {
    super.initState();
    dialogService.registerDialogListener(_showDialog);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child!;
  }

  void _showDialog(AlertRequest request) {
    Alert(
      context: context,
      title: request.title,
      desc: request.description,
      closeFunction: () =>
          dialogService.dialogComplete(AlertResponse(confirmed: false)),
      closeIcon: GestureDetector(
          onTap: () {
            dialogService.dialogComplete(AlertResponse(confirmed: false));
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.close,
            size: Sizes.iconSizeWidget(context),
          )),
      style: AlertStyle(
        titleStyle: Theme.of(context).dialogTheme.titleTextStyle!.copyWith(
              fontSize: Sizes.fontSizeWidget(context),
            ),
        descStyle: Theme.of(context).dialogTheme.contentTextStyle!.copyWith(
              fontSize: displayWidth(context) < 600 ? 12 : 12 * 1.5,
            ),
        titleTextAlign: TextAlign.left,
        descTextAlign: TextAlign.left,
      ),
      buttons: [
        DialogButton(
          color: Theme.of(context).primaryColor,
          onPressed: () {
            dialogService.dialogComplete(AlertResponse(confirmed: true));
            Navigator.of(context).pop();
          },
          child: Text(
            request.buttonTitle ?? 'OK',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: Sizes.fontSizeSubTitleWidget(context),
            ),
          ),
        ),
      ],
    ).show();
  }
}
