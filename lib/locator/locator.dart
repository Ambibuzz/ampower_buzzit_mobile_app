import 'package:ampower_buzzit_mobile/app_viewmodel.dart';
import 'package:ampower_buzzit_mobile/common/service/connectivity_service.dart';
import 'package:ampower_buzzit_mobile/common/service/dialog_service.dart';
import 'package:ampower_buzzit_mobile/common/service/login_api_service.dart';
import 'package:ampower_buzzit_mobile/common/service/logout_api_service.dart';
import 'package:ampower_buzzit_mobile/common/service/navigation_service.dart';
import 'package:ampower_buzzit_mobile/common/service/offline_storage_service.dart';
import 'package:ampower_buzzit_mobile/common/service/storage_service.dart';
import 'package:ampower_buzzit_mobile/common/viewmodel/pdf_download_viewmodel.dart';
import 'package:ampower_buzzit_mobile/config/theme.dart';
import 'package:ampower_buzzit_mobile/service/api_service.dart';
import 'package:ampower_buzzit_mobile/service/camera_service.dart';
import 'package:ampower_buzzit_mobile/service/doctype_caching_service.dart';
import 'package:ampower_buzzit_mobile/service/export_service.dart';
import 'package:ampower_buzzit_mobile/service/fetch_cached_doctype_service.dart';
import 'package:ampower_buzzit_mobile/service/home_service.dart';
import 'package:ampower_buzzit_mobile/service/report_service.dart';
import 'package:ampower_buzzit_mobile/view/login_view.dart';
import 'package:ampower_buzzit_mobile/viewmodel/filters/balance_sheet_filter_bottomsheet_viewmodel.dart';
import 'package:ampower_buzzit_mobile/viewmodel/filters/customer_ledger_filter_bottomsheet_viewmodel.dart';
import 'package:ampower_buzzit_mobile/viewmodel/filters/purchase_invoice_filter_viewmodel.dart';
import 'package:ampower_buzzit_mobile/viewmodel/filters/purchase_order_filter_bottomsheet_viewmodel.dart';
import 'package:ampower_buzzit_mobile/viewmodel/filters/sales_invoice_filter_bottomsheet_viewmodel.dart';
import 'package:ampower_buzzit_mobile/viewmodel/filters/sales_order_filter_bottomsheet_viewmodel.dart';
import 'package:ampower_buzzit_mobile/viewmodel/filters/stock_balance_filter_bottomsheet_viewmodel.dart';
import 'package:ampower_buzzit_mobile/viewmodel/filters/supplier_ledger_filter_bottomsheet_viewmodel.dart';
import 'package:ampower_buzzit_mobile/viewmodel/home_viewmodel.dart';
import 'package:ampower_buzzit_mobile/viewmodel/item_viewmodel.dart';
import 'package:ampower_buzzit_mobile/viewmodel/login_viewmodel.dart';
import 'package:ampower_buzzit_mobile/viewmodel/profile_viewmodel.dart';
import 'package:ampower_buzzit_mobile/viewmodel/purchase_invoice_detail_viewmodel.dart';
import 'package:ampower_buzzit_mobile/viewmodel/purchase_invoice_list_viewmodel.dart';
import 'package:ampower_buzzit_mobile/viewmodel/purchase_order_detail_viewmodel.dart';
import 'package:ampower_buzzit_mobile/viewmodel/purchase_order_list_viewmodel.dart';
import 'package:ampower_buzzit_mobile/viewmodel/report/balance_sheet_report_viewmodel.dart';
import 'package:ampower_buzzit_mobile/viewmodel/report/customer_ledger_report_viewmodel.dart';
import 'package:ampower_buzzit_mobile/viewmodel/report/stock_balance_report_viewmodel.dart';
import 'package:ampower_buzzit_mobile/viewmodel/report/supplier_ledger_report_viewmodel.dart';
import 'package:ampower_buzzit_mobile/viewmodel/sales_invoice_detail_viewmodel.dart';
import 'package:ampower_buzzit_mobile/viewmodel/sales_invoice_list_viewmodel.dart';
import 'package:ampower_buzzit_mobile/viewmodel/sales_order_detail_viewmodel.dart';
import 'package:ampower_buzzit_mobile/viewmodel/sales_order_list_viewmodel.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;
// register singleton
Future setUpLocator() async {
  locator.allowReassignment = true;
  var instance = await StorageService.getInstance();
  if (instance != null) {
    locator.registerSingleton<StorageService>(instance);
  }
  locator
      .registerLazySingleton<ConnectivityService>(() => ConnectivityService());
  locator.registerLazySingleton<CustomTheme>(() => CustomTheme());
  locator.registerLazySingleton<DialogService>(() => DialogService());
  locator.registerLazySingleton<LoginService>(() => LoginService());
  locator.registerLazySingleton<LogoutService>(() => LogoutService());
  locator.registerLazySingleton<NavigationService>(() => NavigationService());
  locator.registerLazySingleton<HomeViewModel>(() => HomeViewModel());
  locator.registerLazySingleton<LoginViewModel>(() => LoginViewModel());
  locator.registerLazySingleton<AppViewModel>(() => AppViewModel());
  locator.registerLazySingleton<HomeService>(() => HomeService());
  locator.registerLazySingleton<ApiService>(() => ApiService());
  locator.registerLazySingleton<PasswordFieldViewModel>(
      () => PasswordFieldViewModel());
  locator.registerLazySingleton<SalesOrderListViewModel>(
      () => SalesOrderListViewModel());
  locator.registerLazySingleton<SalesOrderDetailViewModel>(
      () => SalesOrderDetailViewModel());
  locator.registerLazySingleton<SalesInvoiceListViewModel>(
      () => SalesInvoiceListViewModel());
  locator.registerLazySingleton<SalesInvoiceDetailViewModel>(
      () => SalesInvoiceDetailViewModel());
  locator.registerLazySingleton<PurchaseInvoiceListViewModel>(
      () => PurchaseInvoiceListViewModel());
  locator.registerLazySingleton<PurchaseInvoiceDetailViewModel>(
      () => PurchaseInvoiceDetailViewModel());
  locator.registerLazySingleton<PurchaseOrderListViewModel>(
      () => PurchaseOrderListViewModel());
  locator.registerLazySingleton<PurchaseOrderDetailViewModel>(
      () => PurchaseOrderDetailViewModel());
  locator.registerLazySingleton<OfflineStorage>(() => OfflineStorage());
  locator.registerLazySingleton<SalesOrderFilterBottomSheetViewModel>(
      () => SalesOrderFilterBottomSheetViewModel());
  locator.registerLazySingleton<PurchaseOrderFilterBottomSheetViewModel>(
      () => PurchaseOrderFilterBottomSheetViewModel());
  locator.registerLazySingleton<SalesInvoiceFilterBottomSheetViewModel>(
      () => SalesInvoiceFilterBottomSheetViewModel());
  locator.registerLazySingleton<PurchaseInvoiceFilterBottomSheetViewModel>(
      () => PurchaseInvoiceFilterBottomSheetViewModel());
  locator.registerLazySingleton<PdfDownloadViewModel>(
      () => PdfDownloadViewModel());
  locator.registerLazySingleton<ProfileViewModel>(() => ProfileViewModel());
  locator.registerLazySingleton<CameraService>(() => CameraService());
  locator.registerLazySingleton<ReportService>(() => ReportService());
  locator.registerLazySingleton<StockBalanceReportViewModel>(
      () => StockBalanceReportViewModel());
  locator.registerLazySingleton<StockBalanceFilterBottomSheetViewModel>(
      () => StockBalanceFilterBottomSheetViewModel());
  locator.registerLazySingleton<CustomerLedgerReportViewModel>(
      () => CustomerLedgerReportViewModel());
  locator.registerLazySingleton<SupplierLedgerReportViewModel>(
      () => SupplierLedgerReportViewModel());
  locator.registerLazySingleton<CustomerLedgerFilterBottomSheetViewModel>(
      () => CustomerLedgerFilterBottomSheetViewModel());
  locator.registerLazySingleton<SupplierLedgerFilterBottomSheetViewModel>(
      () => SupplierLedgerFilterBottomSheetViewModel());
  locator.registerLazySingleton<ExportService>(() => ExportService());
  locator.registerLazySingleton<BalanceSheetReportViewModel>(
      () => BalanceSheetReportViewModel());
  locator.registerLazySingleton<BalanceSheetFilterBottomSheetViewModel>(
      () => BalanceSheetFilterBottomSheetViewModel());
  locator.registerLazySingleton<ItemViewModel>(() => ItemViewModel());
  locator.registerLazySingleton<DoctypeCachingService>(
      () => DoctypeCachingService());
  locator.registerLazySingleton<FetchCachedDoctypeService>(
      () => FetchCachedDoctypeService());
}
