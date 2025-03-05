import 'package:ampower_buzzit_mobile/base_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:ampower_buzzit_mobile/locator/locator.dart';
import 'package:ampower_buzzit_mobile/viewmodel/home_viewmodel.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

class StockBalanceFilterBottomSheetViewModel extends BaseViewModel {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  var fromDateController = TextEditingController();
  var toDateController = TextEditingController();
  var customerController = TextEditingController();
  var itemCodeController = TextEditingController();
  var itemGroupController = TextEditingController();
  var warehouseController = TextEditingController();
  var warehouseFocusNode = FocusNode();
  var customerFocusNode = FocusNode();
  var itemCodeFocusNode = FocusNode();
  var itemGroupFocusNode = FocusNode();
  var companyController = TextEditingController();
  var companyFocusNode = FocusNode();

  void clearFilter() {
    fromDateController.clear();
    toDateController.clear();
    customerController.clear();
    itemCodeController.clear();
    itemGroupController.clear();
    warehouseController.clear();
    companyController.clear();
    notifyListeners();
  }

  void initData() async {
    var dateNow = DateTime.now();
    var datePrevMon = Jiffy.now().subtract(months: 1).dateTime;
    fromDateController.text = fromDateController.text.isNotEmpty == true
        ? fromDateController.text
        : DateFormat('yyyy-MM-dd').format(datePrevMon);
    toDateController.text = toDateController.text.isNotEmpty == true
        ? toDateController.text
        : DateFormat('yyyy-MM-dd').format(dateNow);
    companyController.text =
        locator.get<HomeViewModel>().globalDefaults.defaultCompany ?? '';
    notifyListeners();
  }

  void clear() {
    // pastOrderDetailsReportModel.clear();
    // pastOrderDetailsReportBarChart.clear();
    companyController.clear();
    customerController.clear();
    itemCodeController.clear();
    itemGroupController.clear();
    warehouseController.clear();
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
      "from_date": fromDateController.text,
      "to_date": toDateController.text,
      "valuation_field_type": "Currency",
    };
    if (warehouseController.text.isNotEmpty == true) {
      filters["warehouse"] = warehouseController.text;
    }
    if (itemGroupController.text.isNotEmpty == true) {
      filters["item_group"] = itemGroupController.text;
    }
    if (itemCodeController.text.isNotEmpty == true) {
      filters["item_code"] = itemCodeController.text;
    }
    if (companyController.text.isNotEmpty == true) {
      filters["company"] = companyController.text;
    }
    await Future.delayed(const Duration(milliseconds: 100));
    Navigator.of(context).pop(filters);
  }

  void unfocus(BuildContext context) {
    var currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    warehouseFocusNode.unfocus();
    itemGroupFocusNode.unfocus();
    itemCodeFocusNode.unfocus();
    companyFocusNode.unfocus();
    notifyListeners();
  }
}
