import 'package:ampower_buzzit_mobile/base_viewmodel.dart';
import 'package:ampower_buzzit_mobile/locator/locator.dart';
import 'package:ampower_buzzit_mobile/model/stock_balance.dart';
import 'package:ampower_buzzit_mobile/service/api_service.dart';
import 'package:ampower_buzzit_mobile/service/report_service.dart';
import 'package:ampower_buzzit_mobile/util/enums.dart';
import 'package:ampower_buzzit_mobile/viewmodel/home_viewmodel.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

class StockBalanceReportViewModel extends BaseViewModel {
  var stockBalance = StockBalance();
  int? labelLength = 0;
  var labelLeft = '';
  var labelRight = '';
  var itemCodeList = <String>[];
  var itemGroupList = <String>[];
  var warehouseList = <String>[];
  dynamic response;
  dynamic company;

  Future getStockBalanceReport({Map<String, dynamic>? filters}) async {
    setState(ViewState.busy);
    var company = locator.get<HomeViewModel>().globalDefaults.defaultCompany;
    var dateNow = DateTime.now();
    var datePrevMon = Jiffy.now().subtract(months: 1).dateTime;
    var fromDate = DateFormat('yyyy-MM-dd').format(datePrevMon);
    var toDate = DateFormat('yyyy-MM-dd').format(dateNow);
    // function to generate report
    await locator.get<ReportService>().generateStockBalanceReport(
          company,
          fromDate,
          toDate,
          itemCode: "",
          itemGroup: "",
          warehouse: "",
          filters: filters,
        );
    await Future.delayed(const Duration(seconds: 1));
    stockBalance = await locator.get<ReportService>().getStockBalanceReport(
          company,
          fromDate,
          toDate,
          itemCode: "",
          itemGroup: "",
          warehouse: "",
          filters: filters,
        );
    response = await locator.get<ReportService>().getStockBalanceReportResponse(
          company,
          fromDate,
          toDate,
          itemCode: "",
          itemGroup: "",
          warehouse: "",
          filters: filters,
        );
    setState(ViewState.idle);
    notifyListeners();
  }

  Future loadData() async {
    setState(ViewState.busy);
    var queryParams = {'order_by': 'name desc'};
    itemCodeList = await locator.get<ApiService>().getDoctypeFieldList(
      '/api/resource/Item',
      'item_code',
      {},
    );
    itemGroupList = await locator.get<ApiService>().getDoctypeFieldList(
          '/api/resource/Item%20Group',
          'name',
          queryParams,
        );
    warehouseList = await locator.get<ApiService>().getDoctypeFieldList(
          '/api/resource/Warehouse',
          'name',
          queryParams,
        );
    company = await locator.get<ApiService>().searchLink('Company', {});
    setState(ViewState.idle);
    notifyListeners();
  }
}
