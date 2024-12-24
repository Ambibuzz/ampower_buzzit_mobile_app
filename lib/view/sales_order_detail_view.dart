import 'package:ampower_buzzit_mobile/base_view.dart';
import 'package:ampower_buzzit_mobile/common/view/pdf_download_view.dart';
import 'package:ampower_buzzit_mobile/common/widgets/abstract_factory/iwidgetsfactory.dart';
import 'package:ampower_buzzit_mobile/common/widgets/common.dart';
import 'package:ampower_buzzit_mobile/common/widgets/custom_buttons.dart';
import 'package:ampower_buzzit_mobile/common/widgets/custom_toast.dart';
import 'package:ampower_buzzit_mobile/config/theme.dart';
import 'package:ampower_buzzit_mobile/locator/locator.dart';
import 'package:ampower_buzzit_mobile/service/api_service.dart';
import 'package:ampower_buzzit_mobile/util/constants/others.dart';
import 'package:ampower_buzzit_mobile/util/constants/sizes.dart';
import 'package:ampower_buzzit_mobile/util/enums.dart';
import 'package:ampower_buzzit_mobile/util/helpers.dart';
import 'package:ampower_buzzit_mobile/viewmodel/home_viewmodel.dart';
import 'package:ampower_buzzit_mobile/viewmodel/sales_order_detail_viewmodel.dart';
import 'package:ampower_buzzit_mobile/viewmodel/sales_order_list_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:json_table/json_table.dart';
import 'package:provider/provider.dart';

class SalesOrderDetailView extends StatelessWidget {
  final String doctype;
  final String name;
  const SalesOrderDetailView(
      {Key? key, required this.doctype, required this.name})
      : super(key: key);
  static var globalKey =
      GlobalKey<FlutterMentionsState>(debugLabel: 'sales_order_detail_key');

  @override
  Widget build(BuildContext context) {
    return BaseView<SalesOrderDetailViewModel>(
      onModelReady: (model) async {
        var connectivityStatus =
            Provider.of<ConnectivityStatus>(context, listen: false);
        await model.getSalesOrder(doctype, name, connectivityStatus);
        await model.getTransitionState();
      },
      builder: (context, model, child) {
        return model.state == ViewState.busy
            ? WidgetsFactoryList.circularProgressIndicator()
            : salesOrderWidgetMobile(model, context);
      },
    );
  }

  Widget salesOrderWidgetMobile(
      SalesOrderDetailViewModel model, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        key: key,
        children: [
          ...List.generate(model.workflow_actions.length, (index) {
            return InkWell(
              onTap: () async {
                var result = await locator
                    .get<ApiService>()
                    .applyWorkflowTransition(
                        model.payload, model.workflow_actions[index]['action']);
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
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: Sizes.paddingWidget(context)),
            child: Column(
              children: [
                Row(
                  children: [
                    Common.reusableTextWidget(model.so.customer, 16, context,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                    const Spacer(),
                    Common.statusWidget(model.so.status, context),
                    SizedBox(width: Sizes.smallPaddingWidget(context)),
                    PdfDownloadWidget(
                      doctype: doctype,
                      docname: model.so.name ?? '',
                      
                    ),
                    // Common.downloadDoctypeWidget(doctype, model.so.name ?? ''),
                    SizedBox(width: Sizes.smallPaddingWidget(context)),
                  ],
                ),
                const Divider(),
                Common.rowWidget('Name', model.so.name, context),
                Common.widgetSpacingVerticalSm(),
                Common.rowWidget('Address', model.so.addressDisplay, context),
                Common.widgetSpacingVerticalSm(),
                Common.rowWidget(
                    'Transaction Date', defaultDateFormat(model.so.transactiondate!), context),
                Common.widgetSpacingVerticalSm(),
                Common.rowWidget(
                    'Delivery Date', defaultDateFormat(model.so.deliverydate!), context),
                Common.widgetSpacingVerticalSm(),
                Common.rowWidget('Advance Paid',
                    Others.formatter.format(model.so.advancepaid), context),
                Common.widgetSpacingVerticalSm(),
                Common.rowWidget('Base Grand Total',
                    Others.formatter.format(model.so.basegrandtotal), context),
                Common.widgetSpacingVerticalSm(),
                Common.rowWidget(
                    'Company Name', model.so.deliverydate, context),
                Common.widgetSpacingVerticalSm(),
                Common.rowHtmlWidget(
                    'Company Address', model.so.companyAddress, context),
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
                        await model.getSalesOrder(
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

  Widget table(SalesOrderDetailViewModel model, BuildContext context) {
    // var columns = model.customerModel.salesTeam;
    var list = [];
    model.so.salesOrderItems?.forEach((e) => list.add(e.salesOrderToJson()));
    return JsonTable(
      list,
      // showColumnToggle: true,
      // paginationRowCount: 50,
      columns: [
        JsonTableColumn('item_code'),
        JsonTableColumn('item_name'),
        JsonTableColumn('delivery_date'),
        JsonTableColumn('qty'),
        JsonTableColumn('rate'),
        JsonTableColumn('amount'),
      ],
      tableCellBuilder: (value) => Sizes.tableCellBuilder(value, context),
      tableHeaderBuilder: (header) => Sizes.tableHeaderBuilder(header, context),
    );
  }
}
