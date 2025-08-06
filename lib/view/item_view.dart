import 'package:ampower_buzzit_mobile/base_view.dart';
import 'package:ampower_buzzit_mobile/common/widgets/abstract_factory/iwidgetsfactory.dart';
import 'package:ampower_buzzit_mobile/common/widgets/common.dart';
import 'package:ampower_buzzit_mobile/common/widgets/custom_typeahead_formfield.dart';
import 'package:ampower_buzzit_mobile/common/widgets/typeahead_widgets.dart';
import 'package:ampower_buzzit_mobile/locator/locator.dart';
import 'package:ampower_buzzit_mobile/model/bin.dart';
import 'package:ampower_buzzit_mobile/service/fetch_cached_doctype_service.dart';
import 'package:ampower_buzzit_mobile/util/constants/sizes.dart';
import 'package:ampower_buzzit_mobile/util/constants/strings.dart';
import 'package:ampower_buzzit_mobile/util/enums.dart';
import 'package:ampower_buzzit_mobile/viewmodel/item_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemView extends StatelessWidget {
  const ItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<ItemViewModel>(
      onModelReady: (model) async {
        model.init();
        var connectivityStatus =
            Provider.of<ConnectivityStatus>(context, listen: false);
        await model.getItemNameList();
        await model.getItemsModelData(connectivityStatus);
      },
      builder: (context, model, child) {
        return Scaffold(
          appBar: Common.commonAppBar('Item', [], context),
          body: model.state == ViewState.busy
              ? WidgetsFactoryList.circularProgressIndicator()
              : GestureDetector(
                  onTap: () {
                    model.unfocus(context);
                  },
                  child: itemViewWidget(model, context)),
        );
      },
    );
  }

  Widget itemViewWidget(ItemViewModel model, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Sizes.paddingWidget(context)),
      child: Column(
        children: [
          Common.widgetSpacingVerticalLg(),
          itemNameField(model, context),
          Common.widgetSpacingVerticalLg(),
          itemDataWidget(model, context),
        ],
      ),
    );
  }

  Widget itemNameField(ItemViewModel model, BuildContext context) {
    var itemNameList = model.itemList.map((e) => e.itemName as String).toList();

    return CustomTypeAheadFormField(
      controller: model.itemNameController,
      focusNode: model.itemNameFocusNode,
      decoration: Common.inputDecoration(),
      label: 'Item',
      // hideSuggestionOnKeyboardHide: true,
      required: true,
      style: Theme.of(context).textTheme.bodyMedium,
      itemBuilder: (context, item) {
        return TypeAheadWidgets.itemUi(item, context);
      },
      onSuggestionSelected: (suggestion) async {
        model.itemNameController.text = suggestion;
        FocusManager.instance.primaryFocus?.unfocus();
        var item = model.itemList
            .firstWhere((e) => e.itemName == model.itemNameController.text);
        var connectivityStatus =
            Provider.of<ConnectivityStatus>(context, listen: false);
        model.getItem(Strings.item, item.itemCode!, connectivityStatus);
        await model.getBinList(item.itemCode!);
      },
      suggestionsCallback: (pattern) {
        return TypeAheadWidgets.getSuggestions(pattern, itemNameList);
      },
      transitionBuilder: (context, controller, suggestionsBox) {
        return suggestionsBox;
      },
    );
  }

  Widget itemDataWidget(ItemViewModel model, BuildContext context) {
    return model.item == null
        ? const SizedBox()
        : Card(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Sizes.smallPaddingWidget(context),
                  vertical: Sizes.paddingWidget(context)),
              child: Column(
                children: [
                  Common.rowWidget(
                      'Item Name', model.item['item_name'], context),
                  Common.widgetSpacingVerticalSm(),
                  Common.rowWidget(
                      'Item Code', model.item['item_code'], context),
                  Common.widgetSpacingVerticalSm(),
                  Common.rowHtmlWidget(
                      'Description', model.item['description'], context),
                  Common.widgetSpacingVerticalSm(),
                  Common.rowWidget(
                      'Item Group', model.item['item_group'], context),
                  Common.widgetSpacingVerticalSm(),
                  Common.rowWidget('Shell Life',
                      model.item['shelf_life_in_days'].toString(), context),
                  Common.widgetSpacingVerticalSm(),
                  Common.rowWidget(
                      'Default UOM', model.item['stock_uom'], context),
                  Common.widgetSpacingVerticalSm(),
                  Common.rowWidget('Last Purchase Rate',
                      model.item['last_purchase_rate'].toString(), context),
                  Common.widgetSpacingVerticalSm(),
                  binListUi(model.binList, model, context),
                  Common.widgetSpacingVerticalSm(),
                  Row(
                    children: [
                      SizedBox(
                        height: 24,
                        width: 24,
                        child: Checkbox(
                          value: model.item['is_purchase_item'] == 1,
                          onChanged: null,
                        ),
                      ),
                      SizedBox(width: Sizes.smallPaddingWidget(context)),
                      const Text('Allow Purchase'),
                    ],
                  ),
                  Common.widgetSpacingVerticalSm(),
                  Row(
                    children: [
                      SizedBox(
                        height: 24,
                        width: 24,
                        child: Checkbox(
                          value: model.item['is_sales_item'] == 1,
                          onChanged: null,
                        ),
                      ),
                      SizedBox(width: Sizes.smallPaddingWidget(context)),
                      const Text('Allow Sales'),
                    ],
                  ),
                ],
              ),
            ),
          );
  }

  Widget binListUi(
      List<Bin> binList, ItemViewModel model, BuildContext context) {
    return binList.isNotEmpty == true
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Stock Balance Data',
                style: Sizes.subTitleTextStyle(context),
              ),
              ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 0),
                shrinkWrap: true,
                itemCount: binList.length,
                itemBuilder: (context, index) {
                  var bin = model.binList[index];
                  return Card(
                    // margin: EdgeInsets.symmetric(),
                    child: ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: Sizes.smallPaddingWidget(context)),
                      title: Text(
                        bin.warehouse ?? '',
                        style: Sizes.subTitleTextStyle(context),
                      ),
                      trailing: Text(
                        bin.actualQty.toString(),
                        style: Sizes.subTitleTextStyle(context),
                      ),
                    ),
                  );
                },
              ),
            ],
          )
        : const SizedBox();
  }
}
