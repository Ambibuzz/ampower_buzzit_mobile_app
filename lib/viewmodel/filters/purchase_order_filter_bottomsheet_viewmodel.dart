import 'package:ampower_buzzit_mobile/base_viewmodel.dart';
import 'package:ampower_buzzit_mobile/locator/locator.dart';
import 'package:ampower_buzzit_mobile/service/api_service.dart';
import 'package:flutter/material.dart';

class PurchaseOrderFilterBottomSheetViewModel extends BaseViewModel {
  var statusController = TextEditingController();
  var fromDateController = TextEditingController();
  var toDateController = TextEditingController();
  var supplierController = TextEditingController();
  var assignedToController = TextEditingController();
  var itemNameController = TextEditingController();
  var supplierList = <String>[];
  String? statusText = '';

  void clearData() {
    statusController.clear();
    fromDateController.clear();
    toDateController.clear();
    supplierController.clear();
    assignedToController.clear();
    itemNameController.clear();
    statusText = '';
    notifyListeners();
  }

  void setStatusSO(String? status) {
    statusText = status ?? '';
    notifyListeners();
  }

  void loadData() async {
    var queryParams = {'order_by': 'name desc'};
    supplierList = await locator.get<ApiService>().getDoctypeFieldList(
          '/api/resource/Supplier',
          'name',
          queryParams,
        );
  }
}
