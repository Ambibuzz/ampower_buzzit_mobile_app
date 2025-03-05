import 'package:ampower_buzzit_mobile/base_view.dart';
import 'package:ampower_buzzit_mobile/common/widgets/abstract_factory/iwidgetsfactory.dart';
import 'package:ampower_buzzit_mobile/common/widgets/common.dart';
import 'package:ampower_buzzit_mobile/common/widgets/custom_popup_menu_items.dart';
import 'package:ampower_buzzit_mobile/common/widgets/empty_widget.dart';
import 'package:ampower_buzzit_mobile/config/styles.dart';
import 'package:ampower_buzzit_mobile/util/display_helper.dart';
import 'package:ampower_buzzit_mobile/util/enums.dart';
import 'package:ampower_buzzit_mobile/view/filters/supplier_ledger_filter_bottomsheet_viewmodel.dart';
import 'package:ampower_buzzit_mobile/viewmodel/report/supplier_ledger_report_viewmodel.dart';
import 'package:flutter/material.dart';

class SupplierLedgerReportView extends StatelessWidget {
  const SupplierLedgerReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<SupplierLedgerReportViewModel>(
      onModelReady: (model) async {
        await model.loadData();
        await model.getSupplierLedgerReport();
      },
      builder: (context, model, child) {
        return Scaffold(
          appBar: Common.commonAppBar(
              'Supplier Ledger Report',
              [
                Common.filterIconWidget(
                  context,
                  () async {
                    var result =
                        await showSupplierLedgerFilterBottomSheet(context);
                    if (result != null) {
                      await model.getSupplierLedgerReport(
                          filters: result as Map<String, dynamic>);
                    }
                  },
                ),
                CustomPopupMenuItems()
                    .exportCsvPopUpMenu(model.supplierLedger, context),
              ],
              context),
          body: model.state == ViewState.busy
              ? WidgetsFactoryList.circularProgressIndicator()
              : model.supplierLedger == null
                  ? EmptyWidget(
                      onRefresh: () async {
                        await model.loadData();
                        await model.getSupplierLedgerReport();
                      },
                    )
                  : Common.reportTable(
                      model.supplierLedger,
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

  Future<dynamic> showSupplierLedgerFilterBottomSheet(
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
              return SupplierLedgerFilterBottomSheetView(
                controller: controller,
              );
            });
      },
    );
  }
}
