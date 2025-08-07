import 'dart:convert';
import 'package:ampower_buzzit_mobile/base_viewmodel.dart';
import 'package:ampower_buzzit_mobile/common/service/offline_storage_service.dart';
import 'package:ampower_buzzit_mobile/common/service/storage_service.dart';
import 'package:ampower_buzzit_mobile/config/exception.dart';
import 'package:ampower_buzzit_mobile/locator/locator.dart';
import 'package:ampower_buzzit_mobile/model/filter_custom.dart';
import 'package:ampower_buzzit_mobile/model/purchase_order.dart';
import 'package:ampower_buzzit_mobile/service/api_service.dart';
import 'package:ampower_buzzit_mobile/util/constants/strings.dart';
import 'package:ampower_buzzit_mobile/util/dio_helper.dart';
import 'package:ampower_buzzit_mobile/util/enums.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PurchaseOrderListViewModel extends BaseViewModel {
  var purchaseOrderList = <PurchaseOrder>[];
  var filtersSO = [];
  bool isLoading = false;

  //for fetching purchase order list
  Future<List<PurchaseOrder>> getPurchaseOrder(
      List<dynamic> filters, ConnectivityStatus connectivityStatus) async {
    var list = [];
    var solist = <PurchaseOrder>[];
    var url = '/api/resource/Purchase%20Order';
    var queryParams = {
      'fields': '["*"]',
      'limit_page_length': '*',
      'filters': jsonEncode(filters),
      'order_by': 'modified desc'
    };
    filtersSO = filters;
    try {
      // online
      if (connectivityStatus == ConnectivityStatus.cellular ||
          connectivityStatus == ConnectivityStatus.wifi) {
        final response = await DioHelper.dio?.get(
          url,
          queryParameters: queryParams,
        );
        if (response?.statusCode == 200) {
          var data = response?.data;
          list = data['data'];
          for (var listJson in list) {
            solist.add(PurchaseOrder.fromJson(listJson));
          }
          return solist;
        }
      }
      // offline
      else {
        return await fetchCachedPurchaseOrderData();
      }
    } catch (e) {
      exception(e, url, 'getPurchaseOrderList');
    }
    return solist;
  }

  Future<List<PurchaseOrder>> fetchCachedPurchaseOrderData() async {
    // await flutterSimpleToast(
    //     Colors.white, Colors.black, 'Loading Offline Cached Data');
    var data = locator.get<OfflineStorage>().getItem(Strings.purchaseOrder);
    if (data['data'] != null) {
      var podata = jsonDecode(data['data']);
      var polist = PurchaseOrderList.fromJson(podata);
      if (polist.purchaseOrderList != null) {
        return polist.purchaseOrderList!;
      } else {
        return [];
      }
    } else {
      return [];
    }
  }

  Future loadData(
      String? appBarText, List<dynamic> filters, BuildContext context) async {
    // filters
    //     .add(FilterCustom(Strings.PurchaseOrder, 'status', '=', 'To Deliver'));
    isLoading = true;
    notifyListeners();
    var connectivityStatus =
        Provider.of<ConnectivityStatus>(context, listen: false);
    purchaseOrderList = await getPurchaseOrder(filters, connectivityStatus);
    isLoading = false;
    notifyListeners();
  }
}
