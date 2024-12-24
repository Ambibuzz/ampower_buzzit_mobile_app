import 'dart:convert';
import 'dart:io';

import 'package:ampower_buzzit_mobile/common/service/storage_service.dart';
import 'package:ampower_buzzit_mobile/locator/locator.dart';
import 'package:crypto/crypto.dart';

class OfflineStorage {
  static var storage = locator.get<StorageService>().getHiveBox('offline');

  String generateKeyHash(String key) {
    return sha1.convert(utf8.encode(key)).toString();
  }

  Future putItem(String key, dynamic data) async {
    var v = {
      'timestamp': DateTime.now(),
      'data': data,
    };

    await storage.put(key, v);
  }

  dynamic getItem(String key) {
    if (storage.get(key) == null) {
      return {'data': null};
    }
    return storage.get(key);
  }

  // Future remove(String secondaryKey) async {
  //   var k = '${Config().primaryCacheKey!}#@#$secondaryKey';
  //   var keyHash = generateKeyHash(k);
  //   await storage.delete(keyHash);
  // }
}
