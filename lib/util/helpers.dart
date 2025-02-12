import 'dart:io';
import 'dart:convert';
import 'package:ampower_buzzit_mobile/common/service/dialog_service.dart';
import 'package:ampower_buzzit_mobile/common/service/storage_service.dart';
import 'package:ampower_buzzit_mobile/locator/locator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:html/parser.dart';

Future initDb() async {
  await locator.get<StorageService>().initHiveStorage();

  await locator<StorageService>().initHiveBox('offline');
  await locator<StorageService>().initHiveBox('config');
}

Future<XFile?> compressFile(XFile? file, int quality) async {
  final filePath = file?.path;
  var lastIndex = filePath!.lastIndexOf(RegExp(r'.jp'));
  var splitted = filePath.substring(0, (lastIndex));
  final outPath = '${splitted}_out${filePath.substring(lastIndex)}';

  var compressedFile = await FlutterImageCompress.compressAndGetFile(
    file!.path,
    outPath,
    quality: quality,
  );
  return compressedFile;
}

String defaultDateFormat(String date) {
  return DateFormat('dd-MM-yyyy').format(DateTime.parse(date));
}

String getBase64FormateFile(String path) {
  var file = File(path);
  List<int> fileInByte = file.readAsBytesSync();
  var fileInBase64 = base64Encode(fileInByte);
  return fileInBase64;
}

Future<String> getDownloadPath() async {
  if (defaultTargetPlatform == TargetPlatform.android) {
    return '/storage/emulated/0/Download/';
  } else if (defaultTargetPlatform == TargetPlatform.iOS) {
    var downloadsDirectory = await getApplicationDocumentsDirectory();
    return downloadsDirectory.path;
  }
  return '';
}

// Future downloadFile(String fileUrl, String downloadPath) async {
//   await _checkPermission();

//   final absoluteUrl = getAbsoluteUrl(fileUrl);

//   await FlutterDownloader.enqueue(
//     headers: {
//       HttpHeaders.cookieHeader: DioHelper.cookies ?? '',
//     },
//     url: absoluteUrl,
//     savedDir: downloadPath,
//     showNotification:
//         true, // show download progress in status bar (for Android)
//     openFileFromNotification:
//         true, // click on notification to open downloaded file (for Android)
//   );
// }

Future<bool> _checkPermission() async {
  if (defaultTargetPlatform == TargetPlatform.android) {
    if (await Permission.storage.request().isGranted) {
      return true;
    }
  } else {
    return true;
  }
  return false;
}

noInternetAlert(
  BuildContext context,
) async {
  await locator.get<DialogService>().showDialog(
      title: 'Connection Lost',
      description: 'You are not connected to Internet. Retry after sometime.');
}

String parseHtmlString(String htmlString) {
  var parsedString = '';
  final document = parse(htmlString);
  if (document.body?.text.isNotEmpty == true) {
    parsedString = parse(document.body?.text).documentElement?.text ?? '';
  }
  return parsedString;
}

String getServerMessage(String serverMsgs) {
  var errorMsgs = json.decode(serverMsgs) as List;
  var errorStr = '';
  for (var errorMsg in errorMsgs) {
    errorStr += json.decode(errorMsg)['message'];
  }

  return errorStr;
}
