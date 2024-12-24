import 'package:ampower_buzzit_mobile/common/widgets/custom_snackbar.dart';
import 'package:ampower_buzzit_mobile/locator/locator.dart';
import 'package:ampower_buzzit_mobile/service/export_service.dart';
import 'package:ampower_buzzit_mobile/util/constants/sizes.dart';
import 'package:ampower_buzzit_mobile/util/enums.dart';
import 'package:flutter/material.dart';

class CustomPopupMenuItems {
  static PopupMenuItem<ExportType> exportTypeMenu(
      String title, ExportType value, BuildContext context) {
    return PopupMenuItem(
      height: 30,
      value: value,
      child: Row(
        children: [
          Text(title),
        ],
      ),
    );
  }

  Widget exportCsvPopUpMenu(dynamic reportData, BuildContext context) {
    return PopupMenuButton<ExportType>(
      color: Theme.of(context).colorScheme.onPrimary,
      padding: EdgeInsets.zero,
      icon: Icon(Icons.more_vert, size: Sizes.iconSizeWidget(context)),
      onSelected: (ExportType exportType) async {
        // export csv
        if (exportType == ExportType.csv) {
          if (reportData == null) {
            showSnackBar(
              'No Data',
              context,
              backgroundColor: Theme.of(context).cardColor,
            );
          } else {
            await locator
                .get<ExportService>()
                .createCsvFile(reportData, context);
          }
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<ExportType>>[
        CustomPopupMenuItems.exportTypeMenu(
            'Export CSV', ExportType.csv, context),
      ],
    );
  }
}
