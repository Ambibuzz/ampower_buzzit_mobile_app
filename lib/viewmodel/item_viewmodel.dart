import 'dart:convert';

import 'package:ampower_buzzit_mobile/base_viewmodel.dart';
import 'package:ampower_buzzit_mobile/config/exception.dart';
import 'package:ampower_buzzit_mobile/locator/locator.dart';
import 'package:ampower_buzzit_mobile/model/bin.dart';
import 'package:ampower_buzzit_mobile/service/api_service.dart';
import 'package:ampower_buzzit_mobile/service/fetch_cached_doctype_service.dart';
import 'package:ampower_buzzit_mobile/util/apiurls.dart';
import 'package:ampower_buzzit_mobile/util/constants/strings.dart';
import 'package:ampower_buzzit_mobile/util/dio_helper.dart';
import 'package:ampower_buzzit_mobile/util/enums.dart';
import 'package:flutter/material.dart';

class ItemViewModel extends BaseViewModel {
  var itemNameList = <String>[];
  var itemNameController = TextEditingController();
  var itemNameFocusNode = FocusNode();
  dynamic item;
  var binList = <Bin>[];
  var itemList = <Item>[];
  bool isLoading = false;
  bool isItemDataLoading = false;

  void init() {
    itemNameController.clear();
    item = null;
    binList.clear();
  }

  Future getItemsModelData(ConnectivityStatus connectivityStatus) async {
    isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 200));
    itemList = await getItemList([], connectivityStatus);
    isLoading = false;
    notifyListeners();
  }

  Future getBinList(String? itemCode) async {
    isItemDataLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 200));
    var bin =
        await locator.get<FetchCachedDoctypeService>().fetchCachedBinData();
    binList.clear();
    var filteredBinList = bin
        .where(
          (e) => e.itemCode == itemCode,
        )
        .toList();
    binList = filteredBinList;
    isItemDataLoading = false;
    notifyListeners();
  }

  //for fetching purchase order list
  Future<List<Item>> getItemList(
      List<dynamic> filters, ConnectivityStatus connectivityStatus) async {
    var list = [];
    var itemlist = <Item>[];
    var url = '/api/resource/${Strings.item}';
    var queryParams = {
      'fields': '["item_code","item_name"]',
      'limit_page_length': '*',
      'filters': jsonEncode(filters),
      'order_by': 'modified desc'
    };
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
            itemlist.add(Item(
                itemCode: listJson['item_code'],
                itemName: listJson['item_name']));
          }
          return itemlist;
        }
      }
      // offline
      // else {
      //   return await fetchCachedItemData();
      // }
    } catch (e) {
      exception(e, url, 'getItemList');
    }
    return itemlist;
  }

  Future getItem(String doctype, String name,
      ConnectivityStatus connectivityStatus) async {
    isItemDataLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 200));
    final cu = doctypeDetailUrl(doctype, name);
    try {
      if (connectivityStatus == ConnectivityStatus.cellular ||
          connectivityStatus == ConnectivityStatus.wifi) {
        // online
        final response = await locator.get<ApiService>().getDoc(doctype, name);
        if (response != null) {
          item = response['docs'][0];
        }
      } else {
        // var data =
        //     locator.get<OfflineStorage>().getItem(Strings.item);
        // var itemData = jsonDecode(data['data']);
        // if (sodata != null) {
        //   var solist = PurchaseInvoiceList.fromJson(sodata);
        //   if (solist.purchaseInvoiceList != null) {
        //     po = solist.purchaseInvoiceList!.firstWhere((e) => e.name == name);
        //   }
        // }
      }
      notifyListeners();
    } catch (e) {
      exception(e, cu, 'getItem');
    } finally {
      isItemDataLoading = false;
    }
    isItemDataLoading = false;
    notifyListeners();
  }

  Future getItemNameList() async {
    setState(ViewState.busy);
    itemNameList = await locator.get<ApiService>().getDoctypeFieldList(
      '/api/resource/Item',
      'item_name',
      {},
    );

    notifyListeners();
    setState(ViewState.idle);
  }

  void unfocus(BuildContext context) {
    var currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    itemNameFocusNode.unfocus();
    notifyListeners();
  }
}

class Item {
  final String? itemCode;
  final String? itemName;

  Item({required this.itemCode, required this.itemName});
}
