import 'dart:convert';

import 'package:ampower_buzzit_mobile/common/service/offline_storage_service.dart';
import 'package:ampower_buzzit_mobile/locator/locator.dart';
import 'package:ampower_buzzit_mobile/model/bin.dart';
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
}
