import 'package:ampower_buzzit_mobile/common/service/storage_service.dart';
import 'package:ampower_buzzit_mobile/common/view/no_internet_connection_view.dart';
import 'package:ampower_buzzit_mobile/config/logger.dart';
import 'package:ampower_buzzit_mobile/locator/locator.dart';
import 'package:ampower_buzzit_mobile/route/undefined_view.dart';
import 'package:ampower_buzzit_mobile/splash/splash_view.dart';
import 'package:ampower_buzzit_mobile/view/filters/purchase_invoice_filter_bottomsheet_view.dart';
import 'package:ampower_buzzit_mobile/view/filters/purchase_order_filter_bottomsheet_view.dart';
import 'package:ampower_buzzit_mobile/view/filters/sales_invoice_filter_bottomsheet_view.dart';
import 'package:ampower_buzzit_mobile/view/filters/sales_order_filter_bottomsheet_view.dart';
import 'package:ampower_buzzit_mobile/view/home_view.dart';
import 'package:ampower_buzzit_mobile/view/item_view.dart';
import 'package:ampower_buzzit_mobile/view/login_view.dart';
import 'package:ampower_buzzit_mobile/view/profile_view.dart';
import 'package:ampower_buzzit_mobile/view/purchase_invoice_detail_view.dart';
import 'package:ampower_buzzit_mobile/view/purchase_invoice_list_view.dart';
import 'package:ampower_buzzit_mobile/view/purchase_order_detail_view.dart';
import 'package:ampower_buzzit_mobile/view/purchase_order_list_view.dart';
import 'package:ampower_buzzit_mobile/view/report/balance_sheet_report_view.dart';
import 'package:ampower_buzzit_mobile/view/report/customer_ledger_report_view.dart';
import 'package:ampower_buzzit_mobile/view/report/stock_balance_report_view.dart';
import 'package:ampower_buzzit_mobile/view/report/supplier_ledger_report_view.dart';
import 'package:ampower_buzzit_mobile/view/sales_invoice_detail_view.dart';
import 'package:ampower_buzzit_mobile/view/sales_invoice_list_view.dart';
import 'package:ampower_buzzit_mobile/view/sales_order_detail_view.dart';
import 'package:ampower_buzzit_mobile/view/sales_order_list_view.dart';
import 'package:flutter/material.dart';
import 'package:ampower_buzzit_mobile/route/routing_constants.dart';

final log = getLogger('Router');

Route<dynamic> generateRoute(RouteSettings settings) {
  // print(routingData?.route);
  var storageService = locator.get<StorageService>();
  log.i(
      'generateRoute | name: ${settings.name} arguments: ${settings.arguments}');
  switch (settings.name) {
    case balanceSheetReportViewRoute:
      return MaterialPageRoute(
          builder: (context) => const BalanceSheetReportView());
    case customerLedgerReportViewRoute:
      return MaterialPageRoute(
          builder: (context) => const CustomerLedgerReportView());
    case itemViewRoute:
      return MaterialPageRoute(builder: (context) => const ItemView());
    case loginViewRoute:
      return MaterialPageRoute(builder: (context) => LoginView());
    case homeViewRoute:
      return MaterialPageRoute(builder: (context) => HomeView());
    case noInternetConnectionViewRoute:
      return MaterialPageRoute(
          builder: (context) => NoInternetConnectionView());
    case salesOrderListViewRoute:
      var args = settings.arguments as String?;
      return MaterialPageRoute(
          builder: (context) => SalesOrderListView(
                appBarText: args ?? '',
              ));
    case salesOrderDetailViewRoute:
      var args = settings.arguments as List<dynamic>;
      return MaterialPageRoute(
          builder: (context) =>
              SalesOrderDetailView(doctype: args[0], name: args[1]));
    case salesOrderFilterBottomSheetViewRoute:
      return MaterialPageRoute(
          builder: (context) => const SalesOrderFilterBottomSheetView());
    case salesInvoiceFilterBottomSheetViewRoute:
      return MaterialPageRoute(
          builder: (context) => const SalesInvoiceFilterBottomSheetView());
    case salesInvoiceListViewRoute:
      var args = settings.arguments as String?;
      return MaterialPageRoute(
          builder: (context) => SalesInvoiceListView(
                appBarText: args ?? '',
              ));
    case salesInvoiceDetailViewRoute:
      var args = settings.arguments as List<dynamic>;
      return MaterialPageRoute(
          builder: (context) =>
              SalesInvoiceDetailView(doctype: args[0], name: args[1]));
    case splashViewRoute:
      return MaterialPageRoute(builder: (context) => const AmpowerAnimation());
    case stockBalanceReportViewRoute:
      return MaterialPageRoute(
          builder: (context) => const StockBalanceReportView());
    case supplierLedgerReportViewRoute:
      return MaterialPageRoute(
          builder: (context) => const SupplierLedgerReportView());
    case purchaseOrderListViewRoute:
      var args = settings.arguments as String?;
      return MaterialPageRoute(
          builder: (context) => PurchaseOrderListView(
                appBarText: args ?? '',
              ));
    case purchaseOrderDetailViewRoute:
      var args = settings.arguments as List<dynamic>;
      return MaterialPageRoute(
          builder: (context) =>
              PurchaseOrderDetailView(doctype: args[0], name: args[1]));
    case purchaseOrderFilterBottomSheetViewRoute:
      return MaterialPageRoute(
          builder: (context) => const PurchaseOrderFilterBottomSheetView());
    case profileViewRoute:
      return MaterialPageRoute(builder: (context) => ProfileView());
    case purchaseInvoiceFilterBottomSheetViewRoute:
      return MaterialPageRoute(
          builder: (context) => const PurchaseInvoiceFilterBottomSheetView());
    case purchaseInvoiceListViewRoute:
      var args = settings.arguments as String?;
      return MaterialPageRoute(
          builder: (context) => PurchaseInvoiceListView(
                appBarText: args ?? '',
              ));
    case purchaseInvoiceDetailViewRoute:
      var args = settings.arguments as List<dynamic>;
      return MaterialPageRoute(
          builder: (context) =>
              PurchaseInvoiceDetailView(doctype: args[0], name: args[1]));
    // case CustomSplashViewRoute:
    //   return MaterialPageRoute(builder: (context) => CustomSplashView());
    default:
      return MaterialPageRoute(
          builder: (context) => UndefinedView(name: settings.name));
  }
}
