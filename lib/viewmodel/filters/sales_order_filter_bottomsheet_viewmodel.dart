import 'package:ampower_buzzit_mobile/base_viewmodel.dart';
import 'package:ampower_buzzit_mobile/locator/locator.dart';
import 'package:ampower_buzzit_mobile/service/api_service.dart';
import 'package:flutter/material.dart';

class SalesOrderFilterBottomSheetViewModel extends BaseViewModel {
  var statusController = TextEditingController();
  var fromDateController = TextEditingController();
  var toDateController = TextEditingController();
  var customerController = TextEditingController();
  var assignedToController = TextEditingController();
  var itemNameController = TextEditingController();
  var customerList = <String>[];
  String? statusTextSO = '';

  void clearData() {
    statusController.clear();
    fromDateController.clear();
    toDateController.clear();
    customerController.clear();
    assignedToController.clear();
    itemNameController.clear();
    statusTextSO = '';
    notifyListeners();
  }

  void setStatusSO(String? status) {
    statusTextSO = status ?? '';
    notifyListeners();
  }

  void loadData() async {
    var queryParams = {'order_by': 'name desc'};
    customerList = await locator.get<ApiService>().getDoctypeFieldList(
          '/api/resource/Customer',
          'name',
          queryParams,
        );
  }
}
