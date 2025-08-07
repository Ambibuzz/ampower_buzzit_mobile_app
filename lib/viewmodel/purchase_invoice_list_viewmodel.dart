import 'dart:convert';
import 'package:ampower_buzzit_mobile/base_viewmodel.dart';
import 'package:ampower_buzzit_mobile/common/service/offline_storage_service.dart';
import 'package:ampower_buzzit_mobile/config/exception.dart';
import 'package:ampower_buzzit_mobile/locator/locator.dart';
import 'package:ampower_buzzit_mobile/model/purchase_invoice.dart';
import 'package:ampower_buzzit_mobile/model/purchase_order.dart';
import 'package:ampower_buzzit_mobile/service/api_service.dart';
import 'package:ampower_buzzit_mobile/util/constants/strings.dart';
import 'package:ampower_buzzit_mobile/util/dio_helper.dart';
import 'package:ampower_buzzit_mobile/util/enums.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PurchaseInvoiceListViewModel extends BaseViewModel {
  var purchaseInvoiceList = <PurchaseInvoice>[];
  var filtersSO = [];
  bool isLoading = false;

  //for fetching purchase order list
  Future<List<PurchaseInvoice>> getPurchaseInvoice(
      List<dynamic> filters, ConnectivityStatus connectivityStatus) async {
    var list = [];
    var solist = <PurchaseInvoice>[];
    var url = '/api/resource/${Strings.purchaseInvoice}';
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
            solist.add(PurchaseInvoice.fromJson(listJson));
          }
          return solist;
        }
      }
      // offline
      else {
        return await fetchCachedPurchaseInvoiceData();
      }
    } catch (e) {
      exception(e, url, 'getPurchaseInvoiceList');
    }
    return solist;
  }

  Future<List<PurchaseInvoice>> fetchCachedPurchaseInvoiceData() async {
    // await flutterSimpleToast(
    //     Colors.white, Colors.black, 'Loading Offline Cached Data');
    var data = locator.get<OfflineStorage>().getItem(Strings.purchaseInvoice);
    if (data['data'] != null) {
      var podata = jsonDecode(data['data']);
      var polist = PurchaseInvoiceList.fromJson(podata);
      if (polist.purchaseInvoiceList != null) {
        return polist.purchaseInvoiceList!;
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
    //     .add(FilterCustom(Strings.PurchaseInvoice, 'status', '=', 'To Deliver'));
    isLoading = true;
    notifyListeners();
    var connectivityStatus =
        Provider.of<ConnectivityStatus>(context, listen: false);
    purchaseInvoiceList = await getPurchaseInvoice(filters, connectivityStatus);
    isLoading = false;
    notifyListeners();
  }
}
