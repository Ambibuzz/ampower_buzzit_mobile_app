import 'package:ampower_buzzit_mobile/base_view.dart';
import 'package:ampower_buzzit_mobile/common/widgets/abstract_factory/iwidgetsfactory.dart';
import 'package:ampower_buzzit_mobile/common/widgets/common.dart';
import 'package:ampower_buzzit_mobile/common/widgets/custom_dropdown.dart';
import 'package:ampower_buzzit_mobile/common/widgets/custom_textformfield.dart';
import 'package:ampower_buzzit_mobile/common/widgets/custom_typeahead_formfield.dart';
import 'package:ampower_buzzit_mobile/common/widgets/typeahead_widgets.dart';
import 'package:ampower_buzzit_mobile/locator/locator.dart';
import 'package:ampower_buzzit_mobile/util/constants/lists.dart';
import 'package:ampower_buzzit_mobile/util/constants/sizes.dart';
import 'package:ampower_buzzit_mobile/util/constants/strings.dart';
import 'package:ampower_buzzit_mobile/util/display_helper.dart';
import 'package:ampower_buzzit_mobile/util/enums.dart';
import 'package:ampower_buzzit_mobile/viewmodel/filters/balance_sheet_filter_bottomsheet_viewmodel.dart';
import 'package:ampower_buzzit_mobile/viewmodel/report/balance_sheet_report_viewmodel.dart';
import 'package:ampower_buzzit_mobile/viewmodel/report/supplier_ledger_report_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BalanceSheetFilterBottomsheetView extends StatelessWidget {
  const BalanceSheetFilterBottomsheetView(
      {super.key, required this.controller});
  static var formKey =
      GlobalKey<FormState>(debugLabel: 'balance_sheet_report_form_key');
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return BaseView<BalanceSheetFilterBottomSheetViewModel>(
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
                            companyField(model, context),
                            Common.widgetSpacingVerticalLg(),
                            periodicityField(model, context),
                            Common.widgetSpacingVerticalLg(),
                            costCenterField(model, context),
                            Common.widgetSpacingVerticalLg(),
                            projectField(model, context),
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
      BalanceSheetFilterBottomSheetViewModel model, BuildContext context) {
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

  Widget periodicityField(
      BalanceSheetFilterBottomSheetViewModel model, BuildContext context) {
    return CustomDropDown(
      value: model.periodicityText,
      items: Lists.periodicity.map<DropdownMenuItem<String>>((value) {
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
        model.setPeriodicity(value);
      },
      label: 'Periodicity',
      labelStyle: TextStyle(fontSize: Sizes.labelTextSizeWidget(context)),
    );
  }

  Widget companyField(
      BalanceSheetFilterBottomSheetViewModel model, BuildContext context) {
    var companyData =
        locator.get<BalanceSheetReportViewModel>().company['message'] as List;
    var companyList = companyData.map((e) => e['value'] as String).toList();
    return CustomTypeAheadFormField(
      controller: model.companyController,
      focusNode: model.companyFocusNode,
      decoration: Common.inputDecoration(),
      label: 'Company',
      // hideSuggestionOnKeyboardHide: true,
      required: true,
      style: Theme.of(context).textTheme.bodyMedium,
      itemBuilder: (context, item) {
        return TypeAheadWidgets.itemUi(item, context);
      },
      onSuggestionSelected: (suggestion) async {
        model.companyController.text = suggestion;
        FocusManager.instance.primaryFocus?.unfocus();
      },
      suggestionsCallback: (pattern) {
        return TypeAheadWidgets.getSuggestions(pattern, companyList);
      },
      transitionBuilder: (context, controller, suggestionsBox) {
        return suggestionsBox;
      },
    );
  }

  Widget costCenterField(
      BalanceSheetFilterBottomSheetViewModel model, BuildContext context) {
    var costCenterData = locator
        .get<BalanceSheetReportViewModel>()
        .costCenter['message'] as List;
    var costCenterList =
        costCenterData.map((e) => e['value'] as String).toList();
    return CustomTypeAheadFormField(
      controller: model.costCenterController,
      focusNode: model.costCenterFocusNode,
      decoration: Common.inputDecoration(),
      label: 'Cost Center',
      // hideSuggestionOnKeyboardHide: true,
      required: true,
      style: Theme.of(context).textTheme.bodyMedium,
      itemBuilder: (context, item) {
        return TypeAheadWidgets.itemUi(item, context);
      },
      onSuggestionSelected: (suggestion) async {
        model.costCenterController.text = suggestion;
        FocusManager.instance.primaryFocus?.unfocus();
      },
      suggestionsCallback: (pattern) {
        return TypeAheadWidgets.getSuggestions(pattern, costCenterList);
      },
      transitionBuilder: (context, controller, suggestionsBox) {
        return suggestionsBox;
      },
    );
  }

  Widget projectField(
      BalanceSheetFilterBottomSheetViewModel model, BuildContext context) {
    var projectData =
        locator.get<BalanceSheetReportViewModel>().project['message'] as List;
    var projectList = projectData.map((e) => e['value'] as String).toList();
    return CustomTypeAheadFormField(
      controller: model.projectController,
      focusNode: model.projectFocusNode,
      decoration: Common.inputDecoration(),
      label: 'Project',
      // hideSuggestionOnKeyboardHide: true,
      required: true,
      style: Theme.of(context).textTheme.bodyMedium,
      itemBuilder: (context, item) {
        return TypeAheadWidgets.itemUi(item, context);
      },
      onSuggestionSelected: (suggestion) async {
        model.projectController.text = suggestion;
        FocusManager.instance.primaryFocus?.unfocus();
      },
      suggestionsCallback: (pattern) {
        return TypeAheadWidgets.getSuggestions(pattern, projectList);
      },
      transitionBuilder: (context, controller, suggestionsBox) {
        return suggestionsBox;
      },
    );
  }

  Future _selectFromDate(BalanceSheetFilterBottomSheetViewModel model,
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
      BalanceSheetFilterBottomSheetViewModel model, BuildContext context) {
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

  Future _selectToDate(BalanceSheetFilterBottomSheetViewModel model,
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
      BalanceSheetFilterBottomSheetViewModel model, BuildContext context) {
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
