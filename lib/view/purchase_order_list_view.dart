import 'package:ampower_buzzit_mobile/base_view.dart';
import 'package:ampower_buzzit_mobile/common/service/navigation_service.dart';
import 'package:ampower_buzzit_mobile/common/service/storage_service.dart';
import 'package:ampower_buzzit_mobile/common/widgets/abstract_factory/iwidgetsfactory.dart';
import 'package:ampower_buzzit_mobile/common/widgets/common.dart';
import 'package:ampower_buzzit_mobile/common/widgets/empty_widget.dart';
import 'package:ampower_buzzit_mobile/config/styles.dart';
import 'package:ampower_buzzit_mobile/config/theme.dart';
import 'package:ampower_buzzit_mobile/locator/locator.dart';
import 'package:ampower_buzzit_mobile/model/filter_custom.dart';
import 'package:ampower_buzzit_mobile/model/purchase_order.dart';
import 'package:ampower_buzzit_mobile/model/sales_order.dart';
import 'package:ampower_buzzit_mobile/route/routing_constants.dart';
import 'package:ampower_buzzit_mobile/service/api_service.dart';
import 'package:ampower_buzzit_mobile/util/constants/images.dart';
import 'package:ampower_buzzit_mobile/util/constants/sizes.dart';
import 'package:ampower_buzzit_mobile/util/constants/strings.dart';
import 'package:ampower_buzzit_mobile/util/display_helper.dart';
import 'package:ampower_buzzit_mobile/util/enums.dart';
import 'package:ampower_buzzit_mobile/view/filters/purchase_order_filter_bottomsheet_view.dart';
import 'package:ampower_buzzit_mobile/view/purchase_order_detail_view.dart';
import 'package:ampower_buzzit_mobile/viewmodel/filters/purchase_order_filter_bottomsheet_viewmodel.dart';
import 'package:ampower_buzzit_mobile/viewmodel/purchase_order_list_viewmodel.dart';
import 'package:ampower_buzzit_mobile/viewmodel/sales_order_list_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PurchaseOrderListView extends StatelessWidget {
  final String? appBarText;
  const PurchaseOrderListView({super.key, this.appBarText});

  @override
  Widget build(BuildContext context) {
    return BaseView<PurchaseOrderListViewModel>(
      onModelReady: (model) async {
        // locator
        //     .get<SalesOrderFilterBottomSheetViewModel>()
        //     .setStatusSO(Lists.salesOrderStatus[3]);
        await model.loadData(appBarText, [], context);
        locator.get<PurchaseOrderFilterBottomSheetViewModel>().clearData();
      },
      builder: (context, model, child) {
        return Scaffold(
          appBar: Common.commonAppBar(
            'Purchase Order',
            [
              Common.filterIconWidget(
                context,
                () async {
                  var result = await showAddFiltersBottomSheet(model, context);
                  if (result != null) {
                    var filters = result as List;
                    await model.loadData(
                        Strings.purchaseOrder, filters, context);
                  }
                },
              ),
              SizedBox(
                width: Sizes.paddingWidget(context),
              ),
            ],
            context,
          ),
          body: SafeArea(
            child: RefreshIndicator.adaptive(
              onRefresh: () async {
                var connectivityStatus =
                    Provider.of<ConnectivityStatus>(context, listen: false);
                // await locator.get<TargetitHomeViewModel>().cacheSalesOrder(
                //     Strings.salesOrder, connectivityStatus);
                await model.loadData(
                    Strings.purchaseOrder, model.filtersSO, context);
              },
              child: model.isLoading
                  ? purchaseOrderListView(model, context)
                  : model.purchaseOrderList.isEmpty
                      ? EmptyWidget(
                          onRefresh: () async {
                            var connectivityStatus =
                                Provider.of<ConnectivityStatus>(context,
                                    listen: false);
                            // await locator
                            //     .get<TargetitHomeViewModel>()
                            //     .cachePurchaseOrder(
                            //         Strings.PurchaseOrder, connectivityStatus);
                            await model.loadData(Strings.purchaseOrder,
                                model.filtersSO, context);
                          },
                        )
                      : purchaseOrderListView(model, context),
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> showAddFiltersBottomSheet(
      PurchaseOrderListViewModel model, BuildContext context) async {
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
              child: const PurchaseOrderFilterBottomSheetView(),
            );
          },
        );
      },
    );
  }

  Future<dynamic> showPurchaseOrderDetailBottomSheet(
      PurchaseOrderListViewModel model,
      PurchaseOrder purchaseOrder,
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
                child: PurchaseOrderDetailView(
                  doctype: Strings.purchaseOrder,
                  name: purchaseOrder.name ?? '',
                ),
              );
            });
      },
    );
    // return await showModalBottomSheet<dynamic>(
    //   context: context,
    //   showDragHandle: true,
    //   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    //   shape: const RoundedRectangleBorder(
    //     borderRadius: BorderRadius.only(
    //       topLeft: Corners.xxxlRadius,
    //       topRight: Corners.xxxlRadius,
    //     ),
    //   ),
    //   builder: (ctx) {
    //     return PurchaseOrderDetailView(
    //       doctype: Strings.purchaseOrder,
    //       name: purchaseOrder.name ?? '',
    //     );
    //   },
    // );
  }

  Widget purchaseOrderListView(
      PurchaseOrderListViewModel model, BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.symmetric(
            vertical: Sizes.smallPaddingWidget(context) * 1.5,
          ),
          sliver: Skeletonizer.sliver(
            enabled: model.isLoading,
            child: SliverList.builder(
              itemCount: model.purchaseOrderList.length,
              itemBuilder: (context, i) {
                var purchaseOrder = model.purchaseOrderList[i];
                return purchaseOrderTile(model, purchaseOrder, context);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget purchaseOrderTile(PurchaseOrderListViewModel model,
      PurchaseOrder purchaseOrder, BuildContext context) {
    var colWidth = displayWidth(context) < 600
        ? MediaQuery.of(context).size.width * 0.4
        : MediaQuery.of(context).size.width * 0.28;
    return GestureDetector(
      onTap: () async {
        await showPurchaseOrderDetailBottomSheet(model, purchaseOrder, context);
      },
      child: Common.doctypeListViewCardUi(
          Strings.purchaseOrder,
          purchaseOrder.supplierName ?? '',
          purchaseOrder.name ?? '',
          Images.doctypeListCardIcon,
          purchaseOrder.status,
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
