import 'dart:async';
import 'package:ampower_buzzit_mobile/common/model/alert_request.dart';
import 'package:ampower_buzzit_mobile/common/model/alert_response.dart';

class DialogService {
  Function(AlertRequest)? _showDialogListener;
  Completer<AlertResponse>? _dialogCompleter;

  void registerDialogListener(Function(AlertRequest) showDialogListener) {
    _showDialogListener = showDialogListener;
  }

  Future<AlertResponse> showDialog({String? title, String? description,
      String? buttonTitle = 'OK'}) {
    _dialogCompleter = Completer();
    _showDialogListener!(AlertRequest(
      buttonTitle: buttonTitle,
      description: description,
      title: title,
    ));
    return _dialogCompleter!.future;
  }

  void dialogComplete(AlertResponse response) {
    _dialogCompleter?.complete(response);
    _dialogCompleter = null;
  }
}
