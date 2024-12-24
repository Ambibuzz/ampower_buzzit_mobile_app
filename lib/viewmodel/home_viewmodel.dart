import 'package:ampower_buzzit_mobile/base_viewmodel.dart';
import 'package:ampower_buzzit_mobile/common/model/global_defaults.dart';
import 'package:ampower_buzzit_mobile/common/service/navigation_service.dart';
import 'package:ampower_buzzit_mobile/common/service/storage_service.dart';
import 'package:ampower_buzzit_mobile/config/exception.dart';
import 'package:ampower_buzzit_mobile/locator/locator.dart';
import 'package:ampower_buzzit_mobile/model/account_balance.dart';
import 'package:ampower_buzzit_mobile/model/accounts.dart';
import 'package:ampower_buzzit_mobile/model/quicklinks.dart';
import 'package:ampower_buzzit_mobile/model/user.dart';
import 'package:ampower_buzzit_mobile/route/routing_constants.dart';
import 'package:ampower_buzzit_mobile/service/api_service.dart';
import 'package:ampower_buzzit_mobile/service/doctype_caching_service.dart';
import 'package:ampower_buzzit_mobile/service/home_service.dart';
import 'package:ampower_buzzit_mobile/util/constants/images.dart';
import 'package:ampower_buzzit_mobile/util/constants/lists.dart';
import 'package:ampower_buzzit_mobile/util/constants/strings.dart';
import 'package:ampower_buzzit_mobile/util/enums.dart';
import 'package:ampower_buzzit_mobile/util/preference.dart';
import 'package:path/path.dart';

class HomeViewModel extends BaseViewModel {
  Accounts accounts = Accounts();
  AccountBalance accountBalance = AccountBalance();
  var globalDefaults = GlobalDefaults();
  var income = 0.0;
  var expense = 0.0;
  var quickLinksList = <QuickLinks>[
    QuickLinks(
      label: 'Purchase Order',
      routeName: purchaseOrderListViewRoute,
      routeType: '',
      // args: Strings.customer,
      icon: Images.purchaseOrderIcon,
    ),
    QuickLinks(
      label: 'Purchase Invoice',
      routeName: purchaseInvoiceListViewRoute,
      routeType: '',
      // args: Strings.customer,
      icon: Images.purchaseInvoiceIcon,
    ),
    QuickLinks(
      label: 'Sales Order',
      routeName: salesOrderListViewRoute,
      routeType: '',
      // args: Strings.customer,
      icon: Images.salesOrderIcon,
    ),
    QuickLinks(
      label: 'Sales Invoice',
      routeName: salesInvoiceListViewRoute,
      routeType: '',
      // args: Strings.customer,
      icon: Images.salesInvoiceIcon,
    ),
    QuickLinks(
      label: 'Stock Balance Report',
      routeName: stockBalanceReportViewRoute,
      routeType: '',
      // args: Strings.customer,
      icon: Images.stockBalanceIcon,
    ),
    QuickLinks(
      label: 'Customer Ledger Report',
      routeName: customerLedgerReportViewRoute,
      routeType: '',
      icon: Images.customerLedgerIcon,
    ),
    QuickLinks(
      label: 'Supplier Ledger Report',
      routeName: supplierLedgerReportViewRoute,
      routeType: '',
      icon: Images.supplierLedgerIcon,
    ),
    QuickLinks(
      label: 'Balance Sheet Report',
      routeName: balanceSheetReportViewRoute,
      routeType: '',
      icon: Images.balanceSheetIcon,
    ),
    QuickLinks(
      label: 'View Items',
      routeName: itemViewRoute,
      routeType: '',
      icon: Images.itemsIcon,
    ),
  ];
  String? viewTypeText = Lists.viewTypeList[1];
  User user = User();
  var userFullNameList = <String>[];

  Future checkDoctypeCachedOrNot(ConnectivityStatus connectivityStatus) async {
    try {
      var doctypeCachingService = locator.get<DoctypeCachingService>();
      // add api call and if its 200 then only cache
      var statusCode = await locator.get<ApiService>().checkSessionExpired();
      // session not expired cache data
      if (statusCode == 200) {
        await Future.wait([
          doctypeCachingService.cacheDoctype(
              Strings.bin, 1, connectivityStatus),
          doctypeCachingService.cacheDoctype(
              Strings.purchaseInvoice, 7, connectivityStatus),
          doctypeCachingService.cacheDoctype(
              Strings.purchaseOrder, 7, connectivityStatus),
          doctypeCachingService.cacheDoctype(
              Strings.salesInvoice, 7, connectivityStatus),
          doctypeCachingService.cacheDoctype(
              Strings.salesOrder, 7, connectivityStatus),
        ]);
      }
      // session is expired dont cache
      else if (statusCode == 403) {
        locator.get<StorageService>().removeLoggedIn =
            PreferenceVariables.loggedIn;
        await locator.get<NavigationService>().navigateTo(loginViewRoute);
      } else {}
    } catch (e) {
      exception(e, '', 'checkDoctypeCachedOrNot');
    } finally {
      setState(ViewState.idle);
    }
  }

  getUserFullNameList() async {
    userFullNameList = await locator.get<ApiService>().getDoctypeFieldList(
      '/api/resource/User',
      'full_name',
      {},
    );
  }

  Future getUser() async {
    user = await locator
        .get<ApiService>()
        .getUser(locator.get<StorageService>().name);
    notifyListeners();
  }

  void setChart(String? chart) {
    viewTypeText = chart ?? '';
    notifyListeners();
  }

  Future getAccounts() async {
    setState(ViewState.busy);
    accounts = await locator.get<HomeService>().getAccounts();
    notifyListeners();
    setState(ViewState.idle);
  }

  Future getAccountBalance() async {
    setState(ViewState.busy);
    accountBalance =
        await locator.get<HomeService>().getAccountBalance(accounts);
    notifyListeners();
    setState(ViewState.idle);
  }

  void getIncomeAndExpense() async {
    income = 0.0;
    expense = 0.0;
    accountBalance.message?.forEach((e) {
      if (e.rootType == 'Income') {
        income += e.balance!.abs();
      }
      if (e.rootType == 'Expense') {
        expense += e.balance!.abs();
      }
    });
    notifyListeners();
  }

  Future getGlobalDefaults() async {
    globalDefaults = await locator.get<ApiService>().getGlobalDefaults();
    notifyListeners();
  }
}
