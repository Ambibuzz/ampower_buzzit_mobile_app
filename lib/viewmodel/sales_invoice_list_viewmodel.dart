import 'dart:convert';
import 'package:ampower_buzzit_mobile/base_viewmodel.dart';
import 'package:ampower_buzzit_mobile/common/service/offline_storage_service.dart';
import 'package:ampower_buzzit_mobile/config/exception.dart';
import 'package:ampower_buzzit_mobile/locator/locator.dart';
import 'package:ampower_buzzit_mobile/model/sales_invoice.dart';
import 'package:ampower_buzzit_mobile/service/api_service.dart';
import 'package:ampower_buzzit_mobile/util/constants/strings.dart';
import 'package:ampower_buzzit_mobile/util/dio_helper.dart';
import 'package:ampower_buzzit_mobile/util/enums.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SalesInvoiceListViewModel extends BaseViewModel {
  var salesInvoiceList = <SalesInvoice>[];
  var filtersSO = [];
  bool isLoading = false;

  //for fetching sales invoice list
  Future<List<SalesInvoice>> getSalesInvoice(
      List<dynamic> filters, ConnectivityStatus connectivityStatus) async {
    var list = [];
    var solist = <SalesInvoice>[];
    var url = '/api/resource/${Strings.salesInvoice}';
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
            solist.add(SalesInvoice.fromJson(listJson));
          }
          return solist;
        }
      }
      // offline
      else {
        return await fetchCachedSalesInvoiceData();
      }
    } catch (e) {
      exception(e, url, 'getSalesInvoiceList');
    }
    return solist;
  }

  Future<List<SalesInvoice>> fetchCachedSalesInvoiceData() async {
    // await flutterSimpleToast(
    //     Colors.white, Colors.black, 'Loading Offline Cached Data');
    var data = locator.get<OfflineStorage>().getItem(Strings.salesInvoice);
    if (data['data'] != null) {
      var sodata = jsonDecode(data['data']);
      var solist = SalesInvoiceList.fromJson(sodata);
      if (solist.salesInvoiceList != null) {
        return solist.salesInvoiceList!;
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
    //     .add(FilterCustom(Strings.SalesInvoice, 'status', '=', 'To Deliver'));
    isLoading = true;
    notifyListeners();
    var connectivityStatus =
        Provider.of<ConnectivityStatus>(context, listen: false);
    salesInvoiceList = await getSalesInvoice(filters, connectivityStatus);
    isLoading = false;
    notifyListeners();
  }
}
