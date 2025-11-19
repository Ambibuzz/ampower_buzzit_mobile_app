import 'dart:convert';

import 'package:ampower_buzzit_mobile/common/model/currency_model.dart';
import 'package:ampower_buzzit_mobile/common/service/offline_storage_service.dart';
import 'package:ampower_buzzit_mobile/common/widgets/custom_toast.dart';
import 'package:ampower_buzzit_mobile/locator/locator.dart';
import 'package:ampower_buzzit_mobile/model/bin.dart';
import 'package:ampower_buzzit_mobile/model/purchase_invoice.dart';
import 'package:ampower_buzzit_mobile/model/purchase_order.dart';
import 'package:ampower_buzzit_mobile/model/sales_invoice.dart';
import 'package:ampower_buzzit_mobile/model/sales_order.dart';
import 'package:ampower_buzzit_mobile/service/api_service.dart';
import 'package:ampower_buzzit_mobile/util/constants/strings.dart';
import 'package:ampower_buzzit_mobile/util/enums.dart';
import 'package:ampower_buzzit_mobile/viewmodel/purchase_invoice_list_viewmodel.dart';
import 'package:ampower_buzzit_mobile/viewmodel/purchase_order_list_viewmodel.dart';
import 'package:ampower_buzzit_mobile/viewmodel/sales_invoice_list_viewmodel.dart';
import 'package:ampower_buzzit_mobile/viewmodel/sales_order_list_viewmodel.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class DoctypeCachingService {
  Future reCacheDoctype(ConnectivityStatus connectivityStatus) async {
    await Future.wait([
      cacheBin(Strings.bin, connectivityStatus),
      cachePurchaseInvoice(Strings.purchaseInvoice, connectivityStatus),
      cachePurchaseOrder(Strings.purchaseOrder, connectivityStatus),
      cacheSalesInvoice(Strings.salesInvoice, connectivityStatus),
      cacheSalesOrder(Strings.salesOrder, connectivityStatus),
      cacheCurrency(Strings.currency, connectivityStatus),
    ]);
  }

  Future cacheDoctype(String doctype, int cacheDays,
      ConnectivityStatus connectivityStatus) async {
    var data = locator.get<OfflineStorage>().getItem(doctype);
    if (data['data'] == null) {
      // cache bin
      if (doctype == Strings.bin) {
        await cacheBin(doctype, connectivityStatus);
      }
      // cache purchase invoice
      else if (doctype == Strings.purchaseInvoice) {
        await cachePurchaseInvoice(doctype, connectivityStatus);
      }
      // cache purchase order
      else if (doctype == Strings.purchaseOrder) {
        await cachePurchaseOrder(doctype, connectivityStatus);
      }
      // cache sales invoice
      else if (doctype == Strings.salesInvoice) {
        await cacheSalesInvoice(doctype, connectivityStatus);
      }
      // cache sales order
      else if (doctype == Strings.salesOrder) {
        await cacheSalesOrder(doctype, connectivityStatus);
      }
      // cache currency
      else if (doctype == Strings.currency) {
        await cacheCurrency(doctype, connectivityStatus);
      }
    } else {
      if (data['timestamp'] != null) {
        var timestamp = data['timestamp'] as DateTime;
        var timeNow = DateTime.now();
        var difference = timeNow.difference(timestamp);
        if (difference.inDays > cacheDays) {
          // cache doctype
          var connectionStatus = await (Connectivity().checkConnectivity());
          if (connectionStatus == ConnectivityResult.none) {
            await flutterSimpleToast(
                Colors.white, Colors.black, 'Check your internet connection');
          } else if (connectionStatus == ConnectivityResult.mobile ||
              connectionStatus == ConnectivityResult.wifi) {
            // cache bin
            if (doctype == Strings.bin) {
              await cacheBin(doctype, connectivityStatus);
            }
            // cache purchase invoice
            else if (doctype == Strings.purchaseInvoice) {
              await cachePurchaseInvoice(doctype, connectivityStatus);
            }
            // cache purchase order
            else if (doctype == Strings.purchaseOrder) {
              await cachePurchaseOrder(doctype, connectivityStatus);
            }
            // cache sales invoice
            else if (doctype == Strings.salesInvoice) {
              await cacheSalesInvoice(doctype, connectivityStatus);
            }
            // cache sales order
            else if (doctype == Strings.salesOrder) {
              await cacheSalesOrder(doctype, connectivityStatus);
            }
            // cache currency
            else if (doctype == Strings.currency) {
              await cacheCurrency(doctype, connectivityStatus);
            } else {}
          }
        } else {
          // do nothing
        }
      }
    }
  }

  Future cacheBin(String doctype, ConnectivityStatus connectivityStatus) async {
    var binlist = await locator
        .get<ApiService>()
        .getBinListFromApi([], connectivityStatus);
    if (binlist.isNotEmpty) {
      await locator
          .get<OfflineStorage>()
          .putItem(doctype, jsonEncode(BinList(binList: binlist).toJson()));
      await showToast('${Strings.bin} synced ');
    }
  }

  Future cacheCurrency(
      String doctype, ConnectivityStatus connectivityStatus) async {
    var clist = <CurrencyModel>[];
    clist =
        await locator.get<ApiService>().getCurrencyList([], connectivityStatus);
    if (clist.isNotEmpty) {
      await locator.get<OfflineStorage>().putItem(
          doctype, jsonEncode(CurrencyList(currencyList: clist).toJson()));
      await showToast('${Strings.currency} synced ');
    }
  }

  Future cachePurchaseInvoice(
      String doctype, ConnectivityStatus connectivityStatus) async {
    var pi = await locator
        .get<PurchaseInvoiceListViewModel>()
        .getPurchaseInvoice([], connectivityStatus);
    if (pi.isNotEmpty) {
      await locator.get<OfflineStorage>().putItem(doctype,
          jsonEncode(PurchaseInvoiceList(purchaseInvoiceList: pi).toJson()));
      await showToast('${Strings.purchaseInvoice} synced ');
    }
  }

  Future cachePurchaseOrder(
      String doctype, ConnectivityStatus connectivityStatus) async {
    var po = await locator
        .get<PurchaseOrderListViewModel>()
        .getPurchaseOrder([], connectivityStatus);
    if (po.isNotEmpty) {
      await locator.get<OfflineStorage>().putItem(doctype,
          jsonEncode(PurchaseOrderList(purchaseOrderList: po).toJson()));
      await showToast('${Strings.purchaseOrder} synced ');
    }
  }

  Future cacheSalesInvoice(
      String doctype, ConnectivityStatus connectivityStatus) async {
    var si = await locator
        .get<SalesInvoiceListViewModel>()
        .getSalesInvoice([], connectivityStatus);
    if (si.isNotEmpty) {
      await locator.get<OfflineStorage>().putItem(
          doctype, jsonEncode(SalesInvoiceList(salesInvoiceList: si).toJson()));
      await showToast('${Strings.salesInvoice} synced ');
    }
  }

  Future cacheSalesOrder(
      String doctype, ConnectivityStatus connectivityStatus) async {
    var so = await locator
        .get<SalesOrderListViewModel>()
        .getSalesOrder([], connectivityStatus);
    if (so.isNotEmpty) {
      await locator.get<OfflineStorage>().putItem(
          doctype, jsonEncode(SalesOrderList(salesOrderList: so).toJson()));
      await showToast('${Strings.salesOrder} synced ');
    }
  }

  Future showToast(String? message) async {
    await flutterSimpleToast(Colors.black, Colors.white, message ?? '');
  }
}
