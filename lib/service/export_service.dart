import 'dart:typed_data';

import 'package:ampower_buzzit_mobile/common/widgets/custom_snackbar.dart';
import 'package:ampower_buzzit_mobile/config/exception.dart';
import 'package:ampower_buzzit_mobile/locator/locator.dart';
import 'dart:io';
import 'package:ampower_buzzit_mobile/viewmodel/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';


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
      // 1. Choose a platform-safe internal directory
      final directory = await getApplicationSupportDirectory();

      // 2. Create full file path
      final filePath = '${directory.path}/$fileName';

      // 3. Write file
      final file = File(filePath);
      await file.writeAsBytes(csvBytes);

      // 4. (Optional) open after save
      await OpenFilex.open(filePath);
    } catch (e) {
      exception(e, '', 'createCsvFile');
    }
  }
}
