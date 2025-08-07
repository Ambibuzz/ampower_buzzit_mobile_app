import 'dart:convert';
import 'package:ampower_buzzit_mobile/base_viewmodel.dart';
import 'package:ampower_buzzit_mobile/common/service/offline_storage_service.dart';
import 'package:ampower_buzzit_mobile/config/exception.dart';
import 'package:ampower_buzzit_mobile/locator/locator.dart';
import 'package:ampower_buzzit_mobile/model/sales_order.dart';
import 'package:ampower_buzzit_mobile/service/api_service.dart';
import 'package:ampower_buzzit_mobile/util/constants/strings.dart';
import 'package:ampower_buzzit_mobile/util/dio_helper.dart';
import 'package:ampower_buzzit_mobile/util/enums.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SalesOrderListViewModel extends BaseViewModel {
  var salesOrderList = <SalesOrder>[];
  var filtersSO = [];
  bool isLoading = false;

  //for fetching sales order list
  Future<List<SalesOrder>> getSalesOrder(
      List<dynamic> filters, ConnectivityStatus connectivityStatus) async {
    var list = [];
    var solist = <SalesOrder>[];
    var url = '/api/resource/Sales%20Order';
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
            solist.add(SalesOrder.fromJson(listJson));
          }
          return solist;
        }
      }
      // offline
      else {
        return await fetchCachedSalesOrderData();
      }
    } catch (e) {
      exception(e, url, 'getSalesOrderList');
    }
    return solist;
  }

  Future<List<SalesOrder>> fetchCachedSalesOrderData() async {
    var data = locator.get<OfflineStorage>().getItem(Strings.salesOrder);
    if (data['data'] != null) {
      var sodata = jsonDecode(data['data']);
      var solist = SalesOrderList.fromJson(sodata);
      if (solist.salesOrderList != null) {
        return solist.salesOrderList!;
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
    //     .add(FilterCustom(Strings.salesOrder, 'status', '=', 'To Deliver'));
    isLoading = true;
    notifyListeners();
    var connectivityStatus =
        Provider.of<ConnectivityStatus>(context, listen: false);
    salesOrderList = await getSalesOrder(filters, connectivityStatus);
    isLoading = false;
    notifyListeners();
  }

  Future<String?> getPhoneNoFromAddress(
      String? linkDoctype, String? linkTitle) async {
    String? mobileNo;
    try {
      final response = await DioHelper.dio?.get(
        '/api/resource/Address',
        queryParameters: {
          'fields': '["*"]',
          'filters':
              '[["Dynamic Link","link_doctype","=","$linkDoctype"],["Dynamic Link","link_title","=","$linkTitle"]]',
          'limit_page_length': '*'
        },
      );

      if (response?.statusCode == 200) {
        var data = response?.data;
        mobileNo = data['data'][0]['phone'];
        return mobileNo;
      }
    } catch (e) {
      exception(e, '/api/resource/Address', 'getPhoneNoFromAddress');
    }
    return null;
  }
}
