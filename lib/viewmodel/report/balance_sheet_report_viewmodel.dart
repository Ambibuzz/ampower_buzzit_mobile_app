import 'package:ampower_buzzit_mobile/base_viewmodel.dart';
import 'package:ampower_buzzit_mobile/locator/locator.dart';
import 'package:ampower_buzzit_mobile/service/api_service.dart';
import 'package:ampower_buzzit_mobile/service/report_service.dart';
import 'package:ampower_buzzit_mobile/util/constants/lists.dart';
import 'package:ampower_buzzit_mobile/util/enums.dart';
import 'package:ampower_buzzit_mobile/viewmodel/home_viewmodel.dart';

class BalanceSheetReportViewModel extends BaseViewModel {
  dynamic reportData;
  dynamic fiscalYearData;
  dynamic costCenter;
  dynamic project;
  dynamic company;

  Future loadData() async {
    setState(ViewState.busy);
    company = await locator.get<ApiService>().searchLink('Company', {});
    costCenter = await locator.get<ApiService>().searchLink(
      'Cost Center',
      {'company': locator.get<HomeViewModel>().globalDefaults.defaultCompany},
    );
    project = await locator.get<ApiService>().searchLink(
      'Project',
      {'company': locator.get<HomeViewModel>().globalDefaults.defaultCompany},
    );
    setState(ViewState.idle);
    notifyListeners();
  }

  Future getBalanceSheetReport({
    Map<String, dynamic>? filters,
  }) async {
    var globalDefaults = locator.get<HomeViewModel>().globalDefaults;
    reportData = null;
    var data = await locator.get<ApiService>().getFiscalYear();
    fiscalYearData = data['message'];
    var fiscalYear = fiscalYearData[0];
    var startDate = fiscalYearData[1];
    var endDate = fiscalYearData[2];

    reportData = await locator.get<ReportService>().getBalanceSheetReport(
        globalDefaults.defaultCompany,
        'Date Range',
        startDate,
        endDate,
        fiscalYear,
        fiscalYear,
        Lists.periodicity[3],
        [],
        [],
        filters: filters);
    notifyListeners();
  }
}
