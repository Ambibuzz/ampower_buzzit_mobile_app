import 'package:ampower_buzzit_mobile/base_view.dart';
import 'package:ampower_buzzit_mobile/common/model/table_data.dart';
import 'package:ampower_buzzit_mobile/common/widgets/abstract_factory/iwidgetsfactory.dart';
import 'package:ampower_buzzit_mobile/common/widgets/common.dart';
import 'package:ampower_buzzit_mobile/common/widgets/custom_textformfield.dart';
import 'package:ampower_buzzit_mobile/common/widgets/custom_typeahead_formfield.dart';
import 'package:ampower_buzzit_mobile/common/widgets/empty_widget.dart';
import 'package:ampower_buzzit_mobile/common/widgets/typeahead_widgets.dart';
import 'package:ampower_buzzit_mobile/config/styles.dart';
import 'package:ampower_buzzit_mobile/config/theme.dart';
import 'package:ampower_buzzit_mobile/locator/locator.dart';
import 'package:ampower_buzzit_mobile/util/constants/others.dart';
import 'package:ampower_buzzit_mobile/util/constants/sizes.dart';
import 'package:ampower_buzzit_mobile/util/constants/strings.dart';
import 'package:ampower_buzzit_mobile/util/display_helper.dart';
import 'package:ampower_buzzit_mobile/util/enums.dart';
import 'package:ampower_buzzit_mobile/view/filters/stock_balance_filter_bottomsheet_view.dart';
import 'package:ampower_buzzit_mobile/viewmodel/filters/stock_balance_filter_bottomsheet_viewmodel.dart';
import 'package:ampower_buzzit_mobile/viewmodel/report/stock_balance_report_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:json_table/json_table.dart';

class StockBalanceReportView extends StatelessWidget {
  const StockBalanceReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<StockBalanceReportViewModel>(
      onModelReady: (model) async {
        // clear filter
        locator.get<StockBalanceFilterBottomSheetViewModel>().clearFilter();
        await model.loadData();
        await model.getStockBalanceReport(true);
      },
      builder: (context, model, child) {
        return Scaffold(
          appBar: Common.commonAppBar(
              'Stock Balance',
              [
                Common.filterIconWidget(
                  context,
                  () async {
                    var result =
                        await showStockBalanceFilterBottomSheet(model, context);
                    if (result != null) {
                      await model.getStockBalanceReport(false,
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
              : (model.stockBalance.message?.result == null ||
                      model.response == null)
                  ? EmptyWidget(
                      onRefresh: () async {
                        await model.loadData();
                        await model.getStockBalanceReport(true);
                      },
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          model.stockBalance.message?.result?.isNotEmpty == true
                              ? Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical:
                                          Sizes.smallPaddingWidget(context) *
                                              1.5,
                                      horizontal:
                                          Sizes.smallPaddingWidget(context) *
                                              1.5),
                                  child: table2(model, context),
                                )
                              : const SizedBox(),
                          const SizedBox(height: 50),
                        ],
                      ),
                    ),
        );
      },
    );
  }

  Future<dynamic> showStockBalanceFilterBottomSheet(
      StockBalanceReportViewModel model, BuildContext context) async {
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
              return StockBalanceFilterBottomSheetView(
                controller: controller,
              );
            });
      },
    );
  }

  Widget table(StockBalanceReportViewModel model, BuildContext context) {
    var columns = model.stockBalance.message?.columns;
    var list = [];
    model.stockBalance.message?.result?.forEach((e) => list.add(e.toJson()));
    return JsonTable(list,
        showColumnToggle: true,
        paginationRowCount: 15,
        filterTitle: 'Filter Columns',
        tableCellBuilder: (value) => Sizes.tableCellBuilder(value, context),
        tableHeaderBuilder: (header) =>
            Sizes.tableHeaderBuilder(header, context),
        columns: columns
            ?.map((e) => JsonTableColumn(e.fieldname, label: e.label))
            .toList());
  }

  // Table with 2
  Widget table2(StockBalanceReportViewModel model, BuildContext context) {
    final List<TableData> headers = [
      TableData(value: 'Item', width: displayWidth(context) * 0.45),
      TableData(value: 'Item Name', width: displayWidth(context) * 0.45),
      TableData(value: 'Item Group', width: displayWidth(context) * 0.6),
      TableData(value: 'Warehouse', width: displayWidth(context) * 0.45),
      TableData(value: 'Stock UOM', width: displayWidth(context) * 0.2),
      TableData(
          value: 'Balance Qty',
          width: displayWidth(context) * 0.3,
          alignment: Alignment.centerRight,
          textAlign: TextAlign.end),
    ];
    final List<List<TableData>> data = [];
    var totalRow = [];
    if (model.response != null) {
      var listData = model.response['message']['result'] as List;
      totalRow = listData[listData.length - 1] as List;
    }

    // var totalRowTextStyle = const TextStyle(fontWeight: FontWeight.bold);
    // var commonWidth = displayWidth(context) * 0.3;

    if (model.stockBalance.message?.result?.isNotEmpty == true) {
      for (var r in model.stockBalance.message!.result!) {
        data.add([
          TableData(
              value:
                  '${(model.stockBalance.message!.result!.indexOf(r) + 1)}. ${r.itemCode}\n',
              width: displayWidth(context) * 0.45),
          TableData(
              value: '${r.itemName}\n', width: displayWidth(context) * 0.45),
          TableData(
              value: '${r.itemGroup}\n', width: displayWidth(context) * 0.6),
          TableData(
              value: '${r.warehouse}\n', width: displayWidth(context) * 0.45),
          TableData(
              value: '${r.stockUom}\n', width: displayWidth(context) * 0.2),
          TableData(
              value: r.balQty != null
                  ? '${Others.formatter.format(r.balQty)}\n'
                  : '0',
              width: displayWidth(context) * 0.3,
              alignment: Alignment.centerRight,
              textAlign: TextAlign.end),
        ]);
      }
    }
    if (totalRow.isNotEmpty) {
      data.add(
        [
          TableData(
              value: 'Total',
              width: displayWidth(context) * 0.45,
              isBold: true),
          TableData(
              value: '', width: displayWidth(context) * 0.45, isBold: true),
          TableData(
              value: '', width: displayWidth(context) * 0.6, isBold: true),
          TableData(
              value: '', width: displayWidth(context) * 0.45, isBold: true),
          TableData(
              value: '', width: displayWidth(context) * 0.2, isBold: true),
          TableData(
              value: totalRow[5].toString().isNotEmpty
                  ? Others.formatter.format(totalRow[5])
                  : Others.formatter.format(0),
              width: displayWidth(context) * 0.3,
              isBold: true,
              alignment: Alignment.centerRight,
              textAlign: TextAlign.end),
        ],
      );
    }

    return Container(
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Freezed Column
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     _buildHeaderCell(headers[0].value, headers[0].width, context),
          //     ...data
          //         .map((row) => _buildCell(
          //             row[0].value, row[0].width, row[0].isBold, context))
          //         .toList(),
          //   ],
          // ),
          // Freezed Column
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderCell(headers[0].value, headers[0].width, context),
              ...data
                  .map((row) => _buildCell(
                      row[0].value, row[0].width, row[0].isBold, context))
                  .toList(),
            ],
          ),
          // Scrollable Columns
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: headers
                        .sublist(2)
                        .map((header) => _buildHeaderCell(
                              header.value,
                              header.width,
                              context,
                              aligment: header.alignment,
                              textAlign: header.textAlign,
                            ))
                        .toList(),
                  ),
                  Column(
                    children: data.map((row) {
                      return Column(
                        children: [
                          Row(
                            children: row
                                .sublist(2)
                                .map((cell) => _buildCell(
                                      cell.value,
                                      cell.width,
                                      cell.isBold,
                                      context,
                                      aligment: cell.alignment,
                                      textAlign: cell.textAlign,
                                    ))
                                .toList(),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(String text, double width, BuildContext context,
      {Alignment? aligment, TextAlign? textAlign}) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: Sizes.extraSmallPaddingWidget(context)),
      alignment: aligment ?? Alignment.centerLeft,
      width: width,
      height: 50,
      color: CustomTheme.tableHeaderColor,
      child: Text(
        text,
        textAlign: textAlign ?? TextAlign.left,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildCell(
      String text, double width, bool isBold, BuildContext context,
      {double? fontSize, Alignment? aligment, TextAlign? textAlign}) {
    return Container(
      padding: const EdgeInsets.all(8),
      alignment: aligment ?? Alignment.topLeft,
      width: width,
      child: Text(
        text,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        textAlign: textAlign ?? TextAlign.left,
        style: TextStyle(
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
