import 'package:ampower_buzzit_mobile/base_view.dart';
import 'package:ampower_buzzit_mobile/common/widgets/abstract_factory/iwidgetsfactory.dart';
import 'package:ampower_buzzit_mobile/common/widgets/common.dart';
import 'package:ampower_buzzit_mobile/common/widgets/empty_widget.dart';
import 'package:ampower_buzzit_mobile/config/styles.dart';
import 'package:ampower_buzzit_mobile/locator/locator.dart';
import 'package:ampower_buzzit_mobile/model/sales_invoice.dart';
import 'package:ampower_buzzit_mobile/util/constants/images.dart';
import 'package:ampower_buzzit_mobile/util/constants/sizes.dart';
import 'package:ampower_buzzit_mobile/util/constants/strings.dart';
import 'package:ampower_buzzit_mobile/util/display_helper.dart';
import 'package:ampower_buzzit_mobile/util/enums.dart';
import 'package:ampower_buzzit_mobile/view/filters/sales_invoice_filter_bottomsheet_view.dart';
import 'package:ampower_buzzit_mobile/view/sales_invoice_detail_view.dart';
import 'package:ampower_buzzit_mobile/viewmodel/filters/sales_invoice_filter_bottomsheet_viewmodel.dart';
import 'package:ampower_buzzit_mobile/viewmodel/sales_invoice_list_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SalesInvoiceListView extends StatelessWidget {
  final String? appBarText;
  const SalesInvoiceListView({super.key, this.appBarText});

  @override
  Widget build(BuildContext context) {
    return BaseView<SalesInvoiceListViewModel>(
      onModelReady: (model) async {
        await model.loadData(appBarText, [], context);
        locator.get<SalesInvoiceFilterBottomSheetViewModel>().clearData();
      },
      builder: (context, model, child) {
        return Scaffold(
          appBar: Common.commonAppBar(
              'Sales Invoice',
              [
                Common.filterIconWidget(
                  context,
                  () async {
                    var result =
                        await showAddFiltersBottomSheet(model, context);
                    if (result != null) {
                      var filters = result as List;
                      await model.loadData(
                          Strings.salesInvoice, filters, context);
                    }
                  },
                ),
                SizedBox(
                  width: Sizes.paddingWidget(context),
                ),
              ],
              context),
          body: RefreshIndicator.adaptive(
            onRefresh: () async {
              var connectivityStatus =
                  Provider.of<ConnectivityStatus>(context, listen: false);
              // await locator.get<TargetitHomeViewModel>().cacheSalesInvoice(
              //     Strings.SalesInvoice, connectivityStatus);
              await model.loadData(
                  Strings.salesInvoice, model.filtersSO, context);
            },
            child: model.isLoading
                ? salesInvoiceListView(model, context)
                : model.salesInvoiceList.isEmpty
                    ? EmptyWidget(
                        onRefresh: () async {
                          var connectivityStatus =
                              Provider.of<ConnectivityStatus>(context,
                                  listen: false);
                          // await locator
                          //     .get<TargetitHomeViewModel>()
                          //     .cacheSalesInvoice(
                          //         Strings.SalesInvoice, connectivityStatus);
                          await model.loadData(
                              Strings.salesInvoice, model.filtersSO, context);
                        },
                      )
                    : salesInvoiceListView(model, context),
          ),
        );
      },
    );
  }

  Future<dynamic> showAddFiltersBottomSheet(
      SalesInvoiceListViewModel model, BuildContext context) async {
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
            return SingleChildScrollView(
              controller: controller,
              child: const SalesInvoiceFilterBottomSheetView(),
            );
          },
        );
      },
    );
  }

  Future<dynamic> showSalesInvoiceDetailBottomSheet(
      SalesInvoiceListViewModel model,
      SalesInvoice salesInvoice,
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
              return SingleChildScrollView(
                controller: controller,
                child: SalesInvoiceDetailView(
                  doctype: Strings.salesInvoice,
                  name: salesInvoice.name ?? '',
                ),
              );
            });
      },
    );
  }

  Widget salesInvoiceListView(
      SalesInvoiceListViewModel model, BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.symmetric(
            vertical: Sizes.smallPaddingWidget(context) * 1.5,
          ),
          sliver: Skeletonizer.sliver(
            enabled: model.isLoading,
            child: SliverList.builder(
              itemCount: model.salesInvoiceList.length,
              itemBuilder: (context, i) {
                var salesInvoice = model.salesInvoiceList[i];
                return SalesInvoiceTile(model, salesInvoice, context);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget SalesInvoiceTile(SalesInvoiceListViewModel model,
      SalesInvoice salesInvoice, BuildContext context) {
    var colWidth = displayWidth(context) < 600
        ? MediaQuery.of(context).size.width * 0.4
        : MediaQuery.of(context).size.width * 0.28;
    return GestureDetector(
      onTap: () async {
        await showSalesInvoiceDetailBottomSheet(model, salesInvoice, context);
      },
      child: Common.doctypeListViewCardUi(
          Strings.salesInvoice,
          salesInvoice.customer ?? '',
          salesInvoice.name ?? '',
          Images.doctypeListCardIcon,
          salesInvoice.status,
          context),
    );
  }
}

TextStyle? _listItemTextStyle(BuildContext context) {
  if (displayWidth(context) < 600) {
    return Sizes.subTitleTextStyle(context)?.copyWith(
      fontWeight: FontWeight.bold,
    );
  } else {
    return const TextStyle(
      fontSize: Sizes.fontSizeLargeDevice,
      fontWeight: FontWeight.bold,
    );
  }
}

TextStyle? _listItemSubTitleTextStyle(BuildContext context) {
  if (displayWidth(context) < 600) {
    return const TextStyle(fontSize: 12);
  } else {
    return const TextStyle(fontSize: 13 * 1.5);
  }
}

Widget _widgetVerticalSpacing(BuildContext context) {
  if (displayWidth(context) < 600) {
    return const SizedBox(height: 5);
  } else {
    return const SizedBox(height: 5 * 1.5);
  }
}

Widget _subTitlesWidgets(String? text, BuildContext context) {
  return Row(
    children: [
      SizedBox(
        width: displayWidth(context) -
            Sizes.paddingWidget(context) * 2 -
            Sizes.smallPaddingWidget(context) * 2 -
            Sizes.iconSizeWidget(context) * 2.4,
        child: Text(
          text ?? '',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: _listItemSubTitleTextStyle(context),
        ),
      ),
    ],
  );
}
