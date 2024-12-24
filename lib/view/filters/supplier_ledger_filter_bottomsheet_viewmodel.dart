import 'package:ampower_buzzit_mobile/base_view.dart';
import 'package:ampower_buzzit_mobile/common/widgets/abstract_factory/iwidgetsfactory.dart';
import 'package:ampower_buzzit_mobile/common/widgets/common.dart';
import 'package:ampower_buzzit_mobile/common/widgets/custom_textformfield.dart';
import 'package:ampower_buzzit_mobile/common/widgets/custom_typeahead_formfield.dart';
import 'package:ampower_buzzit_mobile/common/widgets/typeahead_widgets.dart';
import 'package:ampower_buzzit_mobile/locator/locator.dart';
import 'package:ampower_buzzit_mobile/util/constants/sizes.dart';
import 'package:ampower_buzzit_mobile/util/constants/strings.dart';
import 'package:ampower_buzzit_mobile/util/display_helper.dart';
import 'package:ampower_buzzit_mobile/util/enums.dart';
import 'package:ampower_buzzit_mobile/viewmodel/filters/customer_ledger_filter_bottomsheet_viewmodel.dart';
import 'package:ampower_buzzit_mobile/viewmodel/filters/supplier_ledger_filter_bottomsheet_viewmodel.dart';
import 'package:ampower_buzzit_mobile/viewmodel/report/customer_ledger_report_viewmodel.dart';
import 'package:ampower_buzzit_mobile/viewmodel/report/supplier_ledger_report_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SupplierLedgerFilterBottomSheetView extends StatelessWidget {
  const SupplierLedgerFilterBottomSheetView(
      {super.key, required this.controller});
  static var formKey =
      GlobalKey<FormState>(debugLabel: 'supplier_ledger_report_form_key');
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return BaseView<SupplierLedgerFilterBottomSheetViewModel>(
      onModelReady: (model) {
        model.initData();
      },
      builder: (context, model, child) {
        return model.state == ViewState.busy
            ? WidgetsFactoryList.circularProgressIndicator()
            : GestureDetector(
                onTap: () {
                  model.unfocus(context);
                },
                child: SingleChildScrollView(
                  controller: controller,
                  child: Form(
                    key: formKey,
                    child: SizedBox(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Sizes.smallPaddingWidget(context)),
                        child: Column(
                          children: <Widget>[
                            Common.widgetSpacingVerticalXl(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                fromDateField(model, context),
                                SizedBox(
                                    width: Sizes.smallPaddingWidget(context)),
                                toDateField(model, context),
                              ],
                            ),
                            Common.widgetSpacingVerticalLg(),
                            supplierField(model, context),
                            Common.widgetSpacingVerticalLg(),
                            applyFilterButton(model, context),
                            Common.widgetSpacingVerticalLg(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }

  Widget applyFilterButton(
      SupplierLedgerFilterBottomSheetViewModel model, BuildContext context) {
    return Container(
      height: Sizes.buttonHeightTargetitWidget(context),
      width: displayWidth(context),
      padding:
          EdgeInsets.symmetric(horizontal: Sizes.smallPaddingWidget(context)),
      child: ElevatedButton(
        onPressed: () => model.applyFilter(context),
        child: const Text(Strings.done),
      ),
    );
  }

  Widget supplierField(
      SupplierLedgerFilterBottomSheetViewModel model, BuildContext context) {
    return CustomTypeAheadFormField(
      controller: model.supplierController,
      focusNode: model.supplierFocusNode,
      decoration: Common.inputDecoration(),
      label: 'Supplier',
      // hideSuggestionOnKeyboardHide: true,
      required: true,
      style: Theme.of(context).textTheme.bodyMedium,
      itemBuilder: (context, item) {
        return TypeAheadWidgets.itemUi(item, context);
      },
      onSuggestionSelected: (suggestion) async {
        model.supplierController.text = suggestion;
        FocusManager.instance.primaryFocus?.unfocus();
      },
      suggestionsCallback: (pattern) {
        return TypeAheadWidgets.getSuggestions(
            pattern, locator.get<SupplierLedgerReportViewModel>().supplierList);
      },
      transitionBuilder: (context, controller, suggestionsBox) {
        return suggestionsBox;
      },
    );
  }

  Future _selectFromDate(SupplierLedgerFilterBottomSheetViewModel model,
      BuildContext context) async {
    model.unfocus(context);
    var picked = await showDatePicker(
        context: context,
        initialDate: model.startDate,
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100));
    if (picked != null) {
      model.setFromDate(picked);
      model.fromDateController.text =
          DateFormat('yyyy-MM-dd').format(picked).toString();
    }
  }

  Widget fromDateField(
      SupplierLedgerFilterBottomSheetViewModel model, BuildContext context) {
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

  Future _selectToDate(SupplierLedgerFilterBottomSheetViewModel model,
      BuildContext context) async {
    model.unfocus(context);
    var picked = await showDatePicker(
        context: context,
        initialDate: model.endDate,
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100));
    if (picked != null) {
      model.setToDate(picked);
      model.toDateController.text =
          DateFormat('yyyy-MM-dd').format(picked).toString();
    }
  }

  Widget toDateField(
      SupplierLedgerFilterBottomSheetViewModel model, BuildContext context) {
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
}
