import 'dart:convert';

import 'package:ampower_buzzit_mobile/config/exception.dart';
import 'package:ampower_buzzit_mobile/locator/locator.dart';
import 'package:ampower_buzzit_mobile/model/account_balance.dart';
import 'package:ampower_buzzit_mobile/model/accounts.dart';
import 'package:ampower_buzzit_mobile/util/dio_helper.dart';
import 'package:ampower_buzzit_mobile/viewmodel/home_viewmodel.dart';

class HomeService {
  Future<Accounts> getAccounts() async {
    Accounts accounts;
    // final url = userFromFullName(fullname);
    var url = '/api/method/erpnext.accounts.utils.get_children';
    var queryParams = {
      "doctype": "Account",
      "parent": locator.get<HomeViewModel>().globalDefaults.defaultCompany,
      "company": locator.get<HomeViewModel>().globalDefaults.defaultCompany,
      "is_root": true,
    };
    try {
      final response = await DioHelper.dio?.post(
        url,
        queryParameters: queryParams,
      );

      if (response?.statusCode == 200) {
        accounts = Accounts.fromJson(response?.data);
        return accounts;
      }
    } catch (e) {
      exception(e, url, 'getAccounts');
    }
    return Accounts();
  }

  Future<AccountBalance> getAccountBalance(Accounts accounts) async {
    AccountBalance accountBalance;
    // final url = userFromFullName(fullname);
    var url = '/api/method/erpnext.accounts.utils.get_account_balances';
    var queryParams = {
      "accounts": jsonEncode(accounts.message?.map((e) => e.toJson()).toList()),
      "company": locator.get<HomeViewModel>().globalDefaults.defaultCompany,
    };
    try {
      final response = await DioHelper.dio?.post(
        url,
        queryParameters: queryParams,
      );

      if (response?.statusCode == 200) {
        accountBalance = AccountBalance.fromJson(response?.data);
        return accountBalance;
      }
    } catch (e) {
      exception(e, url, 'getAccountBalance');
    }
    return AccountBalance();
  }
}
