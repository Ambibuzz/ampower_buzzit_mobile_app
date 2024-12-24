import 'package:ampower_buzzit_mobile/common/widgets/custom_snackbar.dart';
import 'package:ampower_buzzit_mobile/config/exception.dart';
import 'package:ampower_buzzit_mobile/locator/locator.dart';
import 'dart:io';
import 'package:ampower_buzzit_mobile/viewmodel/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ExportService {
  Future<void> createCsvFile(dynamic reportData,BuildContext context) async {
    var dateTime = DateTime.now();
    try {
      // Request storage permissions (Android only)
      if (Platform.isAndroid) {
        var status = await Permission.storage.request();
        if (!status.isGranted) {
          showSnackBar(
            "Storage permission denied",
            context,
            backgroundColor: Theme.of(context).cardColor,
          );
          return;
        }
      }

      // Get the Downloads directory
      Directory? downloadsDirectory;
      if (Platform.isAndroid) {
        downloadsDirectory = Directory('/storage/emulated/0/Download');
      } else if (Platform.isIOS) {
        downloadsDirectory = await getApplicationDocumentsDirectory();
      }

      if (downloadsDirectory == null) {
        showSnackBar("Unable to find Downloads directory", context,
            backgroundColor: Theme.of(context).cardColor);
        return;
      }

      // Create the CSV file
      final filePath =
          '${downloadsDirectory.path}/general-ledger-${dateTime.year}-${dateTime.month}-${dateTime.day}-${dateTime.hour}${dateTime.minute}${dateTime.second}.csv';
      final file = File(filePath);
      var globalDefaults = locator.get<HomeViewModel>().globalDefaults;
      var columns = reportData['message']['columns'] as List<dynamic>;
      var columnKeys = <String>[];
      var headerString = '';
      var rowString = '';
      columns.forEach(
        (element) {
          headerString = headerString + '"${element['label']}",';
          columnKeys.add('${element['fieldname']}');
        },
      );
      headerString = '$headerString\n';

      var result = reportData['message']['result'] as List<dynamic>;
      result.forEach(
        (e) {
          columnKeys.forEach(
            (ck) {
              rowString = rowString + '"${e[ck] ?? ""}",';
            },
          );
          rowString = '$rowString\n';
        },
      );
      await file.writeAsString(headerString,
          mode: FileMode.write); // Write headerString

      await file.writeAsString(rowString,
          mode: FileMode.append); // Write headerString
    } catch (e) {
      exception(e, '', 'createCsvFile');
    }
  }
}
