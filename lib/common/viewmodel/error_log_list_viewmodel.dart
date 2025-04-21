import 'dart:convert';

import 'package:ampower_buzzit_mobile/base_viewmodel.dart';
import 'package:ampower_buzzit_mobile/common/model/error_log.dart';
import 'package:ampower_buzzit_mobile/common/service/offline_storage_service.dart';
import 'package:ampower_buzzit_mobile/config/exception.dart';
import 'package:ampower_buzzit_mobile/locator/locator.dart';

class ErrorLogListViewModel extends BaseViewModel {
  var errorLogList = <ErrorLog>[];

  Future getErrorLogList() async {
    errorLogList = await getErrorLogListFromCache();
    // sort error logs by recent
    errorLogList.sort((a, b) => b.id!.compareTo(a.id!));
    notifyListeners();
  }

  Future<List<ErrorLog>> getErrorLogListFromCache() async {
    var errorLog = <ErrorLog>[];
    try {
      var data = locator.get<OfflineStorage>().getItem('errorlog');

      if (data['data'] != null) {
        var el = ErrorLogList.fromJson(jsonDecode(data['data']));
        if (el.errorLogList?.isNotEmpty == true) {
          errorLog = el.errorLogList!;
          return errorLog;
        } else {
          return errorLog;
        }
      } else {
        return [];
      }
    } catch (e) {
      exception(e, '', 'getErrorLogListFromCache');
      return [];
    }
  }
}