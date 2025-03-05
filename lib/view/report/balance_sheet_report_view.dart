import 'package:ampower_buzzit_mobile/base_view.dart';
import 'package:ampower_buzzit_mobile/common/widgets/abstract_factory/iwidgetsfactory.dart';
import 'package:ampower_buzzit_mobile/common/widgets/common.dart';
import 'package:ampower_buzzit_mobile/common/widgets/empty_widget.dart';
import 'package:ampower_buzzit_mobile/config/styles.dart';
import 'package:ampower_buzzit_mobile/locator/locator.dart';
import 'package:ampower_buzzit_mobile/util/constants/sizes.dart';
import 'package:ampower_buzzit_mobile/util/display_helper.dart';
import 'package:ampower_buzzit_mobile/util/enums.dart';
import 'package:ampower_buzzit_mobile/view/filters/balance_sheet_filter_bottomsheet_view.dart';
import 'package:ampower_buzzit_mobile/viewmodel/filters/balance_sheet_filter_bottomsheet_viewmodel.dart';
import 'package:ampower_buzzit_mobile/viewmodel/report/balance_sheet_report_viewmodel.dart';
import 'package:flutter/material.dart';

class BalanceSheetReportView extends StatelessWidget {
  const BalanceSheetReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<BalanceSheetReportViewModel>(
      onModelReady: (model) async {
        // clear filter
        locator.get<BalanceSheetFilterBottomSheetViewModel>().clearFilter();
        await model.loadData();
        await model.getBalanceSheetReport();
      },
      builder: (context, model, child) {
        return Scaffold(
          appBar: Common.commonAppBar(
              'Balance Sheet Report',
              [
                Common.filterIconWidget(
                  context,
                  () async {
                    var result =
                        await showBalanceSheetFilterBottomSheet(context);
                    if (result != null) {
                      await model.getBalanceSheetReport(
                          filters: result as Map<String, dynamic>);
                    }
                  },
                ),
                SizedBox(
                  width: Sizes.paddingWidget(context),
                ),
              ],
              context),
          body: model.state == ViewState.busy
              ? WidgetsFactoryList.circularProgressIndicator()
              : model.reportData == null
                  ? EmptyWidget(
                      onRefresh: () async {
                        await model.loadData();
                        await model.getBalanceSheetReport();
                      },
                    )
                  : Common.reportTableWithHiddenColumns(
                      model.reportData, <String>['currency'], context),
        );
      },
    );
  }

  Future<dynamic> showBalanceSheetFilterBottomSheet(
      BuildContext context) async {
    return await showModalBottomSheet<dynamic>(
      constraints: BoxConstraints(
        minWidth: displayWidth(context),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Corners.xxxlRadius,
          topRight: Corners.xxxlRadius,
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return DraggableScrollableSheet(
            expand: false,
            builder: (context, controller) {
              return BalanceSheetFilterBottomsheetView(
                controller: controller,
              );
            });
      },
    );
  }
}
