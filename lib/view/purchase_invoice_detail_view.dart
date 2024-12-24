import 'package:ampower_buzzit_mobile/base_view.dart';
import 'package:ampower_buzzit_mobile/common/view/pdf_download_view.dart';
import 'package:ampower_buzzit_mobile/common/widgets/abstract_factory/iwidgetsfactory.dart';
import 'package:ampower_buzzit_mobile/common/widgets/common.dart';
import 'package:ampower_buzzit_mobile/common/widgets/custom_buttons.dart';
import 'package:ampower_buzzit_mobile/common/widgets/custom_toast.dart';
import 'package:ampower_buzzit_mobile/config/styles.dart';
import 'package:ampower_buzzit_mobile/config/theme.dart';
import 'package:ampower_buzzit_mobile/locator/locator.dart';
import 'package:ampower_buzzit_mobile/service/api_service.dart';
import 'package:ampower_buzzit_mobile/util/constants/others.dart';
import 'package:ampower_buzzit_mobile/util/constants/sizes.dart';
import 'package:ampower_buzzit_mobile/util/display_helper.dart';
import 'package:ampower_buzzit_mobile/util/enums.dart';
import 'package:ampower_buzzit_mobile/util/helpers.dart';
import 'package:ampower_buzzit_mobile/viewmodel/home_viewmodel.dart';
import 'package:ampower_buzzit_mobile/viewmodel/purchase_invoice_detail_viewmodel.dart';
import 'package:ampower_buzzit_mobile/viewmodel/purchase_invoice_list_viewmodel.dart';
import 'package:ampower_buzzit_mobile/viewmodel/purchase_order_detail_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:json_table/json_table.dart';
import 'package:provider/provider.dart';

class PurchaseInvoiceDetailView extends StatelessWidget {
  final String doctype;
  final String name;
  const PurchaseInvoiceDetailView(
      {Key? key, required this.doctype, required this.name})
      : super(key: key);
  static var globalKey = GlobalKey<FlutterMentionsState>(
      debugLabel: 'purchase_invoice_detail_key');

  @override
  Widget build(BuildContext context) {
    return BaseView<PurchaseInvoiceDetailViewModel>(
      onModelReady: (model) async {
        var connectivityStatus =
            Provider.of<ConnectivityStatus>(context, listen: false);
        await model.getPurchaseInvoice(doctype, name, connectivityStatus);
        await model.getTransitionState();
      },
      builder: (context, model, child) {
        return model.state == ViewState.busy
            ? WidgetsFactoryList.circularProgressIndicator()
            : purchaseInvoiceWidgetMobile(model, context);
      },
    );
  }

  Widget purchaseInvoiceWidgetMobile(
      PurchaseInvoiceDetailViewModel model, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        key: key,
        children: [
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: Sizes.paddingWidget(context)),
            child: Column(
              children: [
                ...List.generate(model.workflow_actions.length, (index) {
                  return InkWell(
                    onTap: () async {
                      var result = await locator
                          .get<ApiService>()
                          .applyWorkflowTransition(model.payload,
                              model.workflow_actions[index]['action']);
                      if (result['success'] == true) {
                        await model.getTransitionState();
                      }
                    },
                    child: Container(
                      width: 100,
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xFF006CB5),
                      ),
                      child: Center(
                        child: Text(
                          '${model.workflow_actions[index]['action']}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  );
                }),
                Row(
                  children: [
                    Common.reusableTextWidget(
                        model.po.supplierName, 16, context,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                    const Spacer(),
                    Common.statusWidget(model.po.status, context),
                    SizedBox(width: Sizes.smallPaddingWidget(context)),
                    PdfDownloadWidget(
                      doctype: doctype,
                      docname: model.po.name ?? '',
                    ),
                    // Common.downloadDoctypeWidget(doctype, model.po.name ?? ''),
                    SizedBox(width: Sizes.smallPaddingWidget(context)),
                  ],
                ),
                const Divider(),
                Common.rowWidget('Name', model.po.name, context),
                Common.widgetSpacingVerticalSm(),
                Common.rowHtmlWidget(
                    'Shipping Address', model.po.shippingAddress, context),
                Common.widgetSpacingVerticalSm(),
                Common.rowWidget(
                    'Due Date', defaultDateFormat(model.po.dueDate!), context),
                Common.widgetSpacingVerticalSm(),
                Common.rowWidget('Total Advance',
                    Others.formatter.format(model.po.totalAdvance), context),
                Common.rowWidget(
                    'Base Discount',
                    Others.formatter.format(model.po.baseDiscountAmount),
                    context),
                Common.widgetSpacingVerticalSm(),
                Common.rowWidget('Base Grand Total',
                    Others.formatter.format(model.po.baseGrandTotal), context),
                Common.widgetSpacingVerticalSm(),
                Common.rowHtmlWidget(
                    'Billing Address', model.po.billingAddress, context),
                Common.widgetSpacingVerticalSm(),
                // model.po.PurchaseInvoiceItems?.isNotEmpty == true
                //     ? table(model, context)
                //     : const SizedBox(),
                Common.widgetSpacingVerticalSm(),
                const Divider(),
                Common.widgetSpacingVerticalSm(),
                Common.mentionsField(globalKey, context),
                Common.widgetSpacingVerticalSm(),
                Row(
                  children: [
                    CustomButtons.textButton(
                        'Add Comment', Theme.of(context).colorScheme.secondary,
                        () async {
                      var connectivityStatus = Provider.of<ConnectivityStatus>(
                          context,
                          listen: false);
                      var user = locator.get<HomeViewModel>().user;
                      var result = await locator.get<ApiService>().addComment(
                            doctype: doctype,
                            name: name,
                            content: globalKey.currentState!.controller!.text,
                            email: user.email,
                            commentBy: user.fullName,
                          );
                      if (result) {
                        model.clearText();
                        flutterStyledToast(
                            context,
                            'Your comment is added successfully',
                            CustomTheme.toastSuccessColor,
                            textStyle: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                            ));
                        await model.getPurchaseInvoice(
                            doctype, name, connectivityStatus);
                      }
                    }),
                  ],
                ),
                Common.widgetSpacingVerticalSm(),
                const Divider(),
                Common.widgetSpacingVerticalSm(),
                Common.commentsList(model.comments, context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget horizontalSpacing(BuildContext context) {
    return SizedBox(
      width: Sizes.paddingWidget(context),
    );
  }

  Widget table(PurchaseInvoiceDetailViewModel model, BuildContext context) {
    var list = [];
    // model.po.items?.forEach((e) => list.add(e.toJson()));
    return JsonTable(
      list,
      // showColumnToggle: true,
      // paginationRowCount: 50,
      columns: [
        JsonTableColumn('item_code'),
        JsonTableColumn('item_name'),
        JsonTableColumn('qty'),
        JsonTableColumn('rate'),
        JsonTableColumn('amount'),
        JsonTableColumn('received_qty'),
      ],
      tableCellBuilder: (value) => Sizes.tableCellBuilder(value, context),
      tableHeaderBuilder: (header) => Sizes.tableHeaderBuilder(header, context),
    );
  }
}
