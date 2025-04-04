import 'package:ampower_buzzit_mobile/base_viewmodel.dart';
import 'package:ampower_buzzit_mobile/locator/locator.dart';
import 'package:ampower_buzzit_mobile/service/api_service.dart';
import 'package:ampower_buzzit_mobile/service/report_service.dart';
import 'package:ampower_buzzit_mobile/util/enums.dart';
import 'package:ampower_buzzit_mobile/viewmodel/home_viewmodel.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

class SupplierLedgerReportViewModel extends BaseViewModel {
  dynamic supplierLedger;
  var supplierList = <String>[];

  Future loadData() async {
    setState(ViewState.busy);
    var queryParams = {'order_by': 'name desc'};
    supplierList = await locator.get<ApiService>().getDoctypeFieldList(
          '/api/resource/Supplier',
          'name',
          queryParams,
        );
    setState(ViewState.idle);
    notifyListeners();
  }

  Future getSupplierLedgerReport({
    Map<String, dynamic>? filters,
  }) async {
    setState(ViewState.busy);
    var globalDefaults = locator.get<HomeViewModel>().globalDefaults;
    var dateNow = DateTime.now();
    var datePrevMon = Jiffy.now().subtract(months: 1).dateTime;
    var fromDate = DateFormat('yyyy-MM-dd').format(datePrevMon);
    var toDate = DateFormat('yyyy-MM-dd').format(dateNow);
    supplierLedger = null;
    supplierLedger = await locator.get<ReportService>().getGeneralLedgerReport(
        globalDefaults.defaultCompany,
        fromDate,
        toDate,
        'Supplier',
        [],
        'Group by Voucher (Consolidated)',
        filters: filters);
    setState(ViewState.idle);
    notifyListeners();
  }
}
