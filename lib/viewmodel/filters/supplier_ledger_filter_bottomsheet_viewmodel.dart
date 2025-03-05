import 'package:ampower_buzzit_mobile/base_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:ampower_buzzit_mobile/locator/locator.dart';
import 'package:ampower_buzzit_mobile/viewmodel/home_viewmodel.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

class SupplierLedgerFilterBottomSheetViewModel extends BaseViewModel {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  var fromDateController = TextEditingController();
  var toDateController = TextEditingController();
  var supplierController = TextEditingController();
  var supplierFocusNode = FocusNode();

  void clearFilter() {
    fromDateController.clear();
    toDateController.clear();
    supplierController.clear();
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
    notifyListeners();
  }

  void clear() {
    supplierController.clear();
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
    var company = locator.get<HomeViewModel>().globalDefaults.defaultCompany;

    var filters = {
      "company": company,
      "from_date": fromDateController.text,
      "to_date": toDateController.text,
      "party_type": 'Supplier',
      "party": supplierController.text.isNotEmpty == true
          ? [supplierController.text]
          : [],
      "account": [],
      "group_by": 'Group by Voucher (Consolidated)',
      "cost_center": [],
      "project": [],
      "include_dimensions": 1,
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
    supplierFocusNode.unfocus();
    notifyListeners();
  }
}
