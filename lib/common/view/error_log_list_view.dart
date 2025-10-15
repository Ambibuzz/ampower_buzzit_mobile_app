import 'dart:convert';

import 'package:ampower_buzzit_mobile/base_view.dart';
import 'package:ampower_buzzit_mobile/common/model/error_log.dart';
import 'package:ampower_buzzit_mobile/common/viewmodel/error_log_list_viewmodel.dart';
import 'package:ampower_buzzit_mobile/common/widgets/abstract_factory/iwidgetsfactory.dart';
import 'package:ampower_buzzit_mobile/common/widgets/common.dart';
import 'package:ampower_buzzit_mobile/common/widgets/empty_widget.dart';
import 'package:ampower_buzzit_mobile/config/styles.dart';
import 'package:ampower_buzzit_mobile/util/constants/sizes.dart';
import 'package:ampower_buzzit_mobile/util/display_helper.dart';
import 'package:ampower_buzzit_mobile/util/enums.dart';
import 'package:ampower_buzzit_mobile/util/helpers.dart';
import 'package:flutter/material.dart';

class ErrorLogListView extends StatelessWidget {
  const ErrorLogListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<ErrorLogListViewModel>(
      onModelReady: (model) async {
        await model.getErrorLogList();
        // delete hive box data
        // var box = locator.get<StorageService>().getHiveBox('offline');
        // var res = await box.delete('errorlog');
      },
      builder: (context, model, child) {
        return Scaffold(
          appBar: Common.commonAppBar('Error Logs', [], context),
          body: SafeArea(
            child: model.state == ViewState.busy
                ? WidgetsFactoryList.circularProgressIndicator()
                // : SizedBox()
                // /*
                : model.errorLogList.isNotEmpty
                    ? errorLogList(model, context)
                    : Center(
                        child: EmptyWidget(
                          height: displayHeight(context),
                        ),
                      ),
          ),
          // */
        );
      },
    );
  }

  Widget errorLogList(ErrorLogListViewModel model, BuildContext context) {
    return ListView.builder(
      itemCount: model.errorLogList.length,
      padding: EdgeInsets.symmetric(
        vertical: Sizes.smallPaddingWidget(context),
        horizontal: Sizes.paddingWidget(context),
      ),
      itemBuilder: (context, index) {
        var errorLog = model.errorLogList[index];
        return errorLogTile(errorLog, context);
      },
    );
  }

  Widget errorLogTile(ErrorLog errorLog, BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: Sizes.smallPaddingWidget(context)),
      child: ClipRRect(
        borderRadius: Corners.xlBorder,
        child: ExpansionTile(
          shape: const RoundedRectangleBorder(borderRadius: Corners.xlBorder),
          tilePadding: EdgeInsets.symmetric(
            horizontal: Sizes.paddingWidget(context),
          ),
          title: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Time : ${errorLog.time}',
                      style: Sizes.titleTextStyle(context)?.copyWith(),
                    ),
                    Text(
                      'Error : ${parseHtmlString(errorLog.exception ?? '')}',
                      style: Sizes.subTitleTextStyle(context),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async {
                  await shareText('Error ', errorLog.error ?? '');
                },
                child: Icon(
                  Icons.share,
                  size: Sizes.iconSizeWidget(context),
                ),
              ),
            ],
          ),
          // initiallyExpanded: true,
          // onExpansionChanged: model.onExpansionChanged,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Sizes.paddingWidget(context),
                vertical: Sizes.paddingWidget(context),
              ),
              child: Column(
                children: [
                  Text('${errorLog.error}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
