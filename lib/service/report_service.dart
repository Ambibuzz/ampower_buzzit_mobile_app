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
          'ignore_prepared_report': true,
          'is_tree': true,
          'parent_field': 'parent_account',
          'are_default_filters': true,
          '_': timestamp
        };
      } else {
        queryParams = {
          'report_name': 'Balance Sheet',
          'filters': jsonEncode(filters),
          'ignore_prepared_report': true,
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
      return null;
    }
    return null;
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
          'ignore_prepared_report': true,
          'are_default_filters': true,
          '_': timestamp
        };
      } else {
        queryParams = {
          'report_name': 'General Ledger',
          'filters': jsonEncode(filters),
          'ignore_prepared_report': true,
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
      return null;
    }
    return null;
  }

  Future<dynamic> getStockBalanceReport(
    String? company,
    String? fromDate,
    String? toDate,
    bool? areDefaultFilters, {
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
        "from_date": fromDate,
        "to_date": toDate,
        "valuation_field_type": "Currency",
        "project": [],
        "customer": [],
      };
      if (company?.isNotEmpty == true) {
        filter["company"] = company;
      }
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
          'ignore_prepared_report': true,
          'are_default_filters': areDefaultFilters,
          '_': timestamp
        };
      }
      // fetching stock balance based on filter
      else {
        queryParams = {
          'report_name': 'Stock Balance',
          'filters': jsonEncode(filters),
          'ignore_prepared_report': true,
          'are_default_filters': areDefaultFilters,
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
      return null;
    }
    return null;
  }

  Future<dynamic> getStockBalanceReportResponse(
    String? company,
    String? fromDate,
    String? toDate,
    bool? areDefaultFilters, {
    String? warehouse,
    String? itemGroup,
    String? itemCode,
    Map<String, dynamic>? filters,
  }) async {
    var url = '/api/method/frappe.desk.query_report.run';
    try {
      var timestamp = DateTime.now().millisecondsSinceEpoch;

      var filter = {
        "from_date": fromDate,
        "to_date": toDate,
        "valuation_field_type": "Currency",
        "project": [],
        "customer": [],
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
      if (company?.isNotEmpty == true) {
        filter["company"] = company;
      }
      var queryParams = <String, dynamic>{};
      if (filters == null) {
        debugPrint('fetching stock balance based on default filter');
        queryParams = {
          'report_name': 'Stock Balance',
          'filters': jsonEncode(filter),
          'ignore_prepared_report': true,
          'are_default_filters': areDefaultFilters,
          '_': timestamp
        };
      } else {
        debugPrint('fetching stock balance based on filter');
        queryParams = {
          'report_name': 'Stock Balance',
          'filters': jsonEncode(filters),
          'ignore_prepared_report': true,
          'are_default_filters': areDefaultFilters,
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
      return null;
    }
    return null;
  }
}
