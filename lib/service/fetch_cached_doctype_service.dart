import 'dart:convert';

import 'package:ampower_buzzit_mobile/common/model/currency_model.dart';
import 'package:ampower_buzzit_mobile/common/service/offline_storage_service.dart';
import 'package:ampower_buzzit_mobile/locator/locator.dart';
import 'package:ampower_buzzit_mobile/model/bin.dart';
import 'package:ampower_buzzit_mobile/model/user.dart';
import 'package:ampower_buzzit_mobile/util/constants/strings.dart';

class FetchCachedDoctypeService {
  Future<List<Bin>> fetchCachedBinData() async {
    var data = locator.get<OfflineStorage>().getItem(Strings.bin);
    if (data['data'] != null) {
      var itemdata = jsonDecode(data['data']);
      var binList = BinList.fromJson(itemdata);
      if (binList.binList != null) {
        return binList.binList!;
      } else {
        return [];
      }
    } else {
      return [];
    }
  }

  Future<List<CurrencyModel>> fetchCachedCurrencyData() async {
    var data = locator.get<OfflineStorage>().getItem(Strings.currency);
    if (data['data'] != null) {
      var cdata = jsonDecode(data['data']);
      var clist = CurrencyList.fromJson(cdata);
      if (clist.currencyList != null) {
        return clist.currencyList!;
      } else {
        return [];
      }
    } else {
      return [];
    }
  }

  User getUser() {
    var userData = locator.get<OfflineStorage>().getItem('user');
    if (userData['data'] == null) {
      return User();
    } else {
      var user = User.fromJson(userData['data']);
      return user;
    }
  }
}
