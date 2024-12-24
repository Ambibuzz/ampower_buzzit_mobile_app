import 'package:ampower_buzzit_mobile/base_view.dart';
import 'package:ampower_buzzit_mobile/common/widgets/abstract_factory/iwidgetsfactory.dart';
import 'package:ampower_buzzit_mobile/common/widgets/common.dart';
import 'package:ampower_buzzit_mobile/common/widgets/custom_popup_menu_items.dart';
import 'package:ampower_buzzit_mobile/config/styles.dart';
import 'package:ampower_buzzit_mobile/util/display_helper.dart';
import 'package:ampower_buzzit_mobile/view/filters/customer_ledger_filter_bottomsheet_viewmodel.dart';
import 'package:ampower_buzzit_mobile/viewmodel/report/customer_ledger_report_viewmodel.dart';
import 'package:flutter/material.dart';

class CustomerLedgerReportView extends StatelessWidget {
  const CustomerLedgerReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<CustomerLedgerReportViewModel>(
      onModelReady: (model) async {
        model.loadData();
        await model.getCustomerLedgerReport();
      },
      builder: (context, model, child) {
        return Scaffold(
          appBar: Common.commonAppBar(
              'Customer Ledger Report',
              [
                Common.filterIconWidget(
                  context,
                  () async {
                    var result =
                        await showCustomerLedgerFilterBottomSheet(context);
                    if (result != null) {
                      await model.getCustomerLedgerReport(
                          filters: result as Map<String, dynamic>);
                    }
                  },
                ),
                CustomPopupMenuItems()
                    .exportCsvPopUpMenu(model.customerLedger, context),
              ],
              context),
          body: model.customerLedger == null
              ? WidgetsFactoryList.circularProgressIndicator()
              : Common.reportTable(
                  model.customerLedger,
                  <String>[
                    'posting_date',
                    'account',
                    'debit',
                    'credit',
                    'balance',
                    'voucher_type',
                    'voucher_no'
                  ],
                  context),
        );
      },
    );
  }

  Future<dynamic> showCustomerLedgerFilterBottomSheet(
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
              return CustomerLedgerFilterBottomSheetView(
                controller: controller,
              );
            });
      },
    );
  }
}
