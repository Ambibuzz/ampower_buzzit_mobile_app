import 'package:ampower_buzzit_mobile/base_view.dart';
import 'package:ampower_buzzit_mobile/common/widgets/abstract_factory/iwidgetsfactory.dart';
import 'package:ampower_buzzit_mobile/common/widgets/common.dart';
import 'package:ampower_buzzit_mobile/common/widgets/custom_dropdown.dart';
import 'package:ampower_buzzit_mobile/common/widgets/custom_textformfield.dart';
import 'package:ampower_buzzit_mobile/common/widgets/custom_typeahead_formfield.dart';
import 'package:ampower_buzzit_mobile/common/widgets/typeahead_widgets.dart';
import 'package:ampower_buzzit_mobile/model/filter_custom.dart';
import 'package:ampower_buzzit_mobile/util/constants/lists.dart';
import 'package:ampower_buzzit_mobile/util/constants/sizes.dart';
import 'package:ampower_buzzit_mobile/util/constants/strings.dart';
import 'package:ampower_buzzit_mobile/util/display_helper.dart';
import 'package:ampower_buzzit_mobile/util/enums.dart';
import 'package:ampower_buzzit_mobile/viewmodel/filters/sales_order_filter_bottomsheet_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SalesOrderFilterBottomSheetView extends StatelessWidget {
  const SalesOrderFilterBottomSheetView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<SalesOrderFilterBottomSheetViewModel>(
      onModelReady: (model) async {
        model.loadData();
      },
      builder: (context, model, child) {
        return model.state == ViewState.busy
            ? WidgetsFactoryList.circularProgressIndicator()
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: Sizes.smallPadding),
                child: Form(
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          fromDateField(model, context),
                          const SizedBox(width: Sizes.smallPadding),
                          toDateField(model, context),
                        ],
                      ),
                      verticalPadding(context),
                      customerField(model, context),
                      verticalPadding(context),
                      statusDropdownField(model, context),
                      SizedBox(height: Sizes.extraSmallPaddingWidget(context)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          clearFilter(model, context),
                        ],
                      ),
                      SizedBox(height: Sizes.extraSmallPaddingWidget(context)),
                      applyFilterButton(model, context),
                      verticalPadding(context),
                    ],
                  ),
                ),
              );
      },
    );
  }

  Widget verticalPadding(BuildContext context) {
    return SizedBox(height: Sizes.paddingWidget(context));
  }

  Widget clearFilter(
      SalesOrderFilterBottomSheetViewModel model, BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Sizes.smallPaddingWidget(context)),
      child: GestureDetector(
        onTap: () {
          model.clearData();
        },
        child: const Text(
          Strings.clear,
          style: TextStyle(color: Colors.red, fontSize: 16),
        ),
      ),
    );
  }

  Widget applyFilterButton(
      SalesOrderFilterBottomSheetViewModel model, BuildContext context) {
    return SizedBox(
      height: Sizes.buttonHeightTargetitWidget(context),
      width: displayWidth(context),
      child: ElevatedButton(
        onPressed: () => applyFilter(model, context),
        child: const Text(Strings.done),
      ),
    );
  }

  void applyFilter(
      SalesOrderFilterBottomSheetViewModel model, BuildContext context) async {
    //["Sales Order","delivery_status","=","Not Delivered"]
    //["Sales Order","transaction_date","=","2023-08-04"]
    //["Sales Order","customer","=","100002651"]
    //["Sales Order","_assign","like","%mohit%"]
    //["Sales Order Item","item_name","like","%parle%"]

    // apply filters
    var filters = <FilterCustom>[];
    if (model.statusTextSO?.isNotEmpty == true) {
      filters.add(
        FilterCustom(Strings.salesOrder, 'status', '=', model.statusTextSO),
      );
    }
    if (model.fromDateController.text.isNotEmpty &&
        model.toDateController.text.isNotEmpty) {
      filters.add(
        FilterCustom(Strings.salesOrder, 'delivery_date', 'Between',
            [model.fromDateController.text, model.toDateController.text]),
      );
    }
    if (model.customerController.text.isNotEmpty) {
      filters.add(
        FilterCustom(
            Strings.salesOrder, 'customer', '=', model.customerController.text),
      );
    }
    if (model.assignedToController.text.isNotEmpty) {
      filters.add(
        FilterCustom(Strings.salesOrder, '_assign', 'like',
            '%${model.assignedToController.text}%'),
      );
    }
    if (model.itemNameController.text.isNotEmpty) {
      filters.add(
        FilterCustom('Sales Order Item', 'item_name', 'like',
            '%${model.itemNameController.text}%'),
      );
    }
    var finalFilterList = [];
    for (var i = 0; i < filters.length; i++) {
      finalFilterList.add(filters[i].toJson());
    }
    await Future.delayed(const Duration(milliseconds: 100));
    Navigator.of(context).pop(finalFilterList);
  }

  Widget itemNameField(
      SalesOrderFilterBottomSheetViewModel model, BuildContext context) {
    return Expanded(
      child: CustomTextFormField(
        controller: model.itemNameController,
        decoration: Common.inputDecoration(),
        label: 'Item Name',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }

  Widget assignedToField(
      SalesOrderFilterBottomSheetViewModel model, BuildContext context) {
    return Expanded(
      child: CustomTextFormField(
        controller: model.assignedToController,
        decoration: Common.inputDecoration(),
        label: 'Assigned To',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }

  Widget customerField(
      SalesOrderFilterBottomSheetViewModel model, BuildContext context) {
    return CustomTypeAheadFormField(
      controller: model.customerController,
      decoration: Common.inputDecoration(),
      label: 'Customer',
      // hideSuggestionOnKeyboardHide: true,
      required: true,
      style: Theme.of(context).textTheme.bodyMedium,
      itemBuilder: (context, item) {
        return TypeAheadWidgets.itemUi(item, context);
      },
      onSuggestionSelected: (suggestion) async {
        model.customerController.text = suggestion;
        FocusManager.instance.primaryFocus?.unfocus();
      },
      suggestionsCallback: (pattern) {
        return TypeAheadWidgets.getSuggestions(pattern, model.customerList);
      },
      transitionBuilder: (context, controller, suggestionsBox) {
        return suggestionsBox;
      },
    );
  }

  Widget statusDropdownField(
      SalesOrderFilterBottomSheetViewModel model, BuildContext context) {
    return CustomDropDown(
      value: model.statusTextSO,
      items: Lists.salesOrderStatus.map<DropdownMenuItem<String>>((value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value.toString(),
            style:
                Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14),
          ),
        );
      }).toList(),
      alignment: CrossAxisAlignment.start,
      onChanged: (String? value) {
        model.setStatusSO(value);
      },
      label: 'Status',
      labelStyle: TextStyle(fontSize: Sizes.labelTextSizeWidget(context)),
    );
  }

  Future _selectToDate(
      SalesOrderFilterBottomSheetViewModel model, BuildContext context) async {
    var picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100));
    if (picked != null) {
      model.toDateController.text =
          DateFormat('yyyy-MM-dd').format(picked).toString();
    }
  }

  Widget toDateField(
      SalesOrderFilterBottomSheetViewModel model, BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _selectToDate(model, context),
        child: AbsorbPointer(
          child: CustomTextFormField(
            controller: model.toDateController,
            keyboardType: TextInputType.datetime,
            decoration: Common.inputDecoration(),
            label: 'To Date',
            labelStyle: Theme.of(context).textTheme.bodyMedium,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ),
    );
  }

  Future _selectFromDate(
      SalesOrderFilterBottomSheetViewModel model, BuildContext context) async {
    var picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100));
    if (picked != null) {
      model.fromDateController.text =
          DateFormat('yyyy-MM-dd').format(picked).toString();
    }
  }

  Widget fromDateField(
      SalesOrderFilterBottomSheetViewModel model, BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _selectFromDate(model, context),
        child: AbsorbPointer(
          child: CustomTextFormField(
            controller: model.fromDateController,
            keyboardType: TextInputType.datetime,
            decoration: Common.inputDecoration(),
            label: 'From Date',
            labelStyle: Theme.of(context).textTheme.bodyMedium,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ),
    );
  }
}
