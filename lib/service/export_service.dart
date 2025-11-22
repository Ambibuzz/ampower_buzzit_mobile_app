import 'dart:typed_data';

import 'package:ampower_buzzit_mobile/common/widgets/custom_snackbar.dart';
import 'package:ampower_buzzit_mobile/config/exception.dart';
import 'package:ampower_buzzit_mobile/locator/locator.dart';
import 'dart:io';
import 'package:ampower_buzzit_mobile/viewmodel/home_viewmodel.dart';
import 'package:file_save_directory/file_save_directory.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class ExportService {
  Future<void> createCsvFile(dynamic reportData, BuildContext context) async {
    var dateTime = DateTime.now();
    try {
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
      final csvContent = headerString + rowString;
      final csvBytes = Uint8List.fromList(csvContent.codeUnits);
      final fileName =
          "general-ledger-${dateTime.year}-${dateTime.month}-${dateTime.day}-${dateTime.hour}${dateTime.minute}${dateTime.second}.csv";
      final savedPath = await FileSaveDirectory.instance.saveFile(
        fileName: fileName,
        fileBytes: csvBytes,
        location: SaveLocation.downloads, // Saves in Downloads folder
        openAfterSave: false, // Set true if you want auto-open
      );
      showSnackBar("CSV saved at: $savedPath", context);
    } catch (e) {
      exception(e, '', 'createCsvFile');
    }
  }
}
