import 'dart:convert';
import 'package:ampower_buzzit_mobile/config/exception.dart';
import 'package:ampower_buzzit_mobile/model/stock_balance.dart';
import 'package:ampower_buzzit_mobile/util/dio_helper.dart';
import 'package:flutter/foundation.dart';

class ReportService {
  Future<dynamic> getBalanceSheetReport(
    String? company,
    String? filterBasedOn,
    String? periodStartDate,
    String? periodEndDate,
    String? fromFiscalYear,
    String? toFiscalYear,
    String? periodicity,
    dynamic costCenter,
    dynamic project, {
    Map<String, dynamic>? filters,
  }) async {
    var url = '/api/method/frappe.desk.query_report.run';
    try {
      var timestamp = DateTime.now().millisecondsSinceEpoch;

      var filter = {
        "company": company,
        "filter_based_on": filterBasedOn,
        "period_start_date": periodStartDate,
        "period_end_date": periodEndDate,
        "from_fiscal_year": fromFiscalYear,
        "to_fiscal_year": toFiscalYear,
        "periodicity": periodicity,
        "cost_center": costCenter,
        "plant": [],
        "project": project,
        "selected_view": "Report",
        "accumulated_values": 1,
        "include_default_book_entries": 1,
      };

      var queryParams = <String, dynamic>{};
      if (filters == null) {
        queryParams = {
          'report_name': 'Balance Sheet',
          'filters': jsonEncode(filter),
          'ignore_prepared_report': false,
          'is_tree': true,
          'parent_field': 'parent_account',
          'are_default_filters': false,
          '_': timestamp
        };
      } else {
        queryParams = {
          'report_name': 'Balance Sheet',
          'filters': jsonEncode(filters),
          'ignore_prepared_report': false,
          'is_tree': true,
          'parent_field': 'parent_account',
          'are_default_filters': false,
          '_': timestamp
        };
      }

      final response = await DioHelper.dio?.get(
        url,
        queryParameters: queryParams,
      );
      if (response?.statusCode == 200) {
        var data = response?.data;
        return data;
      }
    } catch (e) {
      exception(e, url, 'getGeneralLedgerReport');
    }
    return '';
  }

  // get double digit
  String getDoubleDigitDate(int singleDigitDate) {
    if (singleDigitDate.toString().length == 1) {
      return '0$singleDigitDate';
    } else {
      return singleDigitDate.toString();
    }
  }

  Future<dynamic> getGeneralLedgerReport(
    String? company,
    String? fromDate,
    String? toDate,
    String? partyType,
    dynamic party,
    String? groupBy, {
    Map<String, dynamic>? filters,
  }) async {
    var url = '/api/method/frappe.desk.query_report.run';
    try {
      var timestamp = DateTime.now().millisecondsSinceEpoch;

      var filter = {
        "company": company,
        "from_date": fromDate,
        "to_date": toDate,
        "party_type": partyType,
        "party": party,
        "account": [],
        "group_by": groupBy,
        "cost_center": [],
        "project": [],
        "include_dimensions": 1,
        "include_default_book_entries": 1,
      };

      var queryParams = <String, dynamic>{};
      if (filters == null) {
        queryParams = {
          'report_name': 'General Ledger',
          'filters': jsonEncode(filter),
          'are_default_filters': false,
          '_': timestamp
        };
      } else {
        queryParams = {
          'report_name': 'General Ledger',
          'filters': jsonEncode(filters),
          'are_default_filters': false,
          '_': timestamp
        };
      }

      final response = await DioHelper.dio?.get(
        url,
        queryParameters: queryParams,
      );
      if (response?.statusCode == 200) {
        var data = response?.data;
        return data;
      }
    } catch (e) {
      exception(e, url, 'getGeneralLedgerReport');
    }
    return '';
  }

  Future generateStockBalanceReport(
    String? company,
    String? fromDate,
    String? toDate, {
    String? warehouse,
    String? itemGroup,
    String? itemCode,
    Map<String, dynamic>? filters,
  }) async {
    var url = '/api/method/frappe.desk.query_report.background_enqueue_run';
    try {
      var filter = {
        "company": company,
        "from_date": fromDate,
        "to_date": toDate,
        "ignore_closing_balance": 1,
      };
      if (warehouse?.isNotEmpty == true) {
        filter["warehouse"] = warehouse;
      }
      if (itemGroup?.isNotEmpty == true) {
        filter["item_group"] = itemGroup;
      }
      if (itemCode?.isNotEmpty == true) {
        filter["item_code"] = itemCode;
      }
      var queryParams = <String, dynamic>{};
      // generate stock balance based on default filter
      if (filters == null || filters.keys.isEmpty) {
        queryParams = {
          'report_name': 'Stock Balance',
          'filters': jsonEncode(filter),
        };
      }
      // generate stock balance based on filter
      else {
        queryParams = {
          'report_name': 'Stock Balance',
          'filters': jsonEncode(filters),
        };
      }

      final response = await DioHelper.dio?.post(
        url,
        queryParameters: queryParams,
      );
    } catch (e) {
      exception(e, url, 'generateStockBalanceReport');
    }
  }

  Future<StockBalance> getStockBalanceReport(
    String? company,
    String? fromDate,
    String? toDate, {
    String? warehouse,
    String? itemGroup,
    String? itemCode,
    Map<String, dynamic>? filters,
  }) async {
    var sbr = StockBalance();
    var url = '/api/method/frappe.desk.query_report.run';
    try {
      var timestamp = DateTime.now().millisecondsSinceEpoch;

      var filter = {
        "company": company,
        "from_date": fromDate,
        "to_date": toDate,
        "ignore_closing_balance": 1,
      };
      if (warehouse?.isNotEmpty == true) {
        filter["warehouse"] = warehouse;
      }
      if (itemGroup?.isNotEmpty == true) {
        filter["item_group"] = itemGroup;
      }
      if (itemCode?.isNotEmpty == true) {
        filter["item_code"] = itemCode;
      }
      var queryParams = <String, dynamic>{};
      // fetching stock balance based on default filter
      if (filters == null) {
        queryParams = {
          'report_name': 'Stock Balance',
          'filters': jsonEncode(filter),
          'are_default_filters': false,
          '_': timestamp
        };
      }
      // fetching stock balance based on filter
      else {
        queryParams = {
          'report_name': 'Stock Balance',
          'filters': jsonEncode(filters),
          'are_default_filters': false,
          '_': timestamp
        };
      }

      final response = await DioHelper.dio?.get(
        url,
        queryParameters: queryParams,
      );
      if (response?.statusCode == 200) {
        var data = response?.data;
        sbr = StockBalance.fromJson(data);
        return sbr;
      }
    } catch (e) {
      exception(e, url, 'getStockBalanceReport');
    }
    return sbr;
  }

  Future<dynamic> getStockBalanceReportResponse(
    String? company,
    String? fromDate,
    String? toDate, {
    String? warehouse,
    String? itemGroup,
    String? itemCode,
    Map<String, dynamic>? filters,
  }) async {
    var url = '/api/method/frappe.desk.query_report.run';
    try {
      var timestamp = DateTime.now().millisecondsSinceEpoch;

      var filter = {
        "company": company,
        "from_date": fromDate,
        "to_date": toDate,
        "ignore_closing_balance": 1,
      };
      if (warehouse?.isNotEmpty == true) {
        filter["warehouse"] = warehouse;
      }
      if (itemGroup?.isNotEmpty == true) {
        filter["item_group"] = itemGroup;
      }
      if (itemCode?.isNotEmpty == true) {
        filter["item_code"] = itemCode;
      }
      var queryParams = <String, dynamic>{};
      if (filters == null) {
        debugPrint('fetching stock balance based on default filter');
        queryParams = {
          'report_name': 'Stock Balance',
          'filters': jsonEncode(filter),
          'are_default_filters': false,
          '_': timestamp
        };
      } else {
        debugPrint('fetching stock balance based on filter');
        queryParams = {
          'report_name': 'Stock Balance',
          'filters': jsonEncode(filters),
          'are_default_filters': false,
          '_': timestamp
        };
      }

      final response = await DioHelper.dio?.get(
        url,
        queryParameters: queryParams,
      );
      if (response?.statusCode == 200) {
        var data = response?.data;

        return data;
      }
    } catch (e) {
      exception(e, url, 'getStockBalanceReportResponse');
    }
    return '';
  }
}
