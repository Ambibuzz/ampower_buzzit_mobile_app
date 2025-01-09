import 'package:ampower_buzzit_mobile/base_viewmodel.dart';
import 'package:ampower_buzzit_mobile/util/constants/lists.dart';
import 'package:ampower_buzzit_mobile/viewmodel/report/balance_sheet_report_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:ampower_buzzit_mobile/locator/locator.dart';
import 'package:ampower_buzzit_mobile/viewmodel/home_viewmodel.dart';

class BalanceSheetFilterBottomSheetViewModel extends BaseViewModel {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  var fromDateController = TextEditingController();
  var toDateController = TextEditingController();
  var companyController = TextEditingController();
  var companyFocusNode = FocusNode();
  var costCenterController = TextEditingController();
  var costCenterFocusNode = FocusNode();
  var projectController = TextEditingController();
  var projectFocusNode = FocusNode();

  String? fiscalYear;
  String? periodicityText = Lists.periodicity[3];

  void initData() async {
    var fiscalYearData =
        locator.get<BalanceSheetReportViewModel>().fiscalYearData;
    fiscalYear = fiscalYearData[0];
    var startDate = fiscalYearData[1];
    var endDate = fiscalYearData[2];
    companyController.text =
        locator.get<HomeViewModel>().globalDefaults.defaultCompany ?? '';

    fromDateController.text = fromDateController.text.isNotEmpty == true
        ? fromDateController.text
        : startDate;
    toDateController.text = toDateController.text.isNotEmpty == true
        ? toDateController.text
        : endDate;
    notifyListeners();
  }

  void clear() {
    companyController.clear();
    costCenterController.clear();
    projectController.clear();
  }

  void setPeriodicity(String? status) {
    periodicityText = status ?? '';
    notifyListeners();
  }

  void setFromDate(DateTime? date) {
    if (date != null) startDate = date;
    notifyListeners();
  }

  void setToDate(DateTime? date) {
    if (date != null) endDate = date;
    notifyListeners();
  }

  Future applyFilter(BuildContext context) async {
    var filters = {
      "company": companyController.text,
      "filter_based_on": "Date Range",
      "period_start_date": fromDateController.text,
      "period_end_date": toDateController.text,
      "from_fiscal_year": fiscalYear,
      "to_fiscal_year": fiscalYear,
      "periodicity": periodicityText,
      "cost_center": costCenterController.text.isNotEmpty == true
          ? [costCenterController.text]
          : [],
      "project": projectController.text.isNotEmpty == true
          ? [projectController.text]
          : [],
      "selected_view": "Report",
      "accumulated_values": 1,
      "include_default_book_entries": 1,
    };

    await Future.delayed(const Duration(milliseconds: 50));
    Navigator.of(context).pop(filters);
  }

  void unfocus(BuildContext context) {
    var currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    costCenterFocusNode.unfocus();
    projectFocusNode.unfocus();
    companyFocusNode.unfocus();
    notifyListeners();
  }
}
