import 'dart:convert';
import 'dart:io';

import 'package:ampower_buzzit_mobile/common/model/global_defaults.dart';
import 'package:ampower_buzzit_mobile/common/service/offline_storage_service.dart';
import 'package:ampower_buzzit_mobile/common/widgets/custom_toast.dart';
import 'package:ampower_buzzit_mobile/config/exception.dart';
import 'package:ampower_buzzit_mobile/locator/locator.dart';
import 'package:ampower_buzzit_mobile/model/bin.dart';
import 'package:ampower_buzzit_mobile/model/user.dart';
import 'package:ampower_buzzit_mobile/service/fetch_cached_doctype_service.dart';
import 'package:ampower_buzzit_mobile/util/apiurls.dart';
import 'package:ampower_buzzit_mobile/util/constants/sizes.dart';
import 'package:ampower_buzzit_mobile/util/constants/strings.dart';
import 'package:ampower_buzzit_mobile/util/dio_helper.dart';
import 'package:ampower_buzzit_mobile/util/enums.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ApiService {
  //for fetching username

  Future<bool> addComment(
      {required String? doctype,
      required String? name,
      required String? content,
      required String? email,
      required String? commentBy}) async {
    var url = '/api/method/frappe.desk.form.utils.add_comment';
    var queryParams = {
      'reference_doctype': doctype,
      'reference_name': name,
      'content': content,
      'comment_email': email,
      'comment_by': commentBy,
    };
    try {
      final response = await DioHelper.dio?.post(
        url,
        queryParameters: queryParams,
      );

      if (response?.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      exception(e, url, 'addComment');
    }
    return false;
  }

  Future<int> checkSessionExpired() async {
    final url = usernameUrl();
    try {
      final response = await DioHelper.dio?.get(url);
      return response?.statusCode ?? 400;
    } catch (e) {
      exception(e, url, 'checkSessionExpired');
    }
    return 0;
  }

  Future<List<Bin>> getBinListFromApi(
      List<dynamic> filters, ConnectivityStatus connectivityStatus) async {
    var list = [];
    var binlist = <Bin>[];
    var url = '/api/resource/Bin';
    var queryParams = {
      'fields':
          '["name","item_code","modified","warehouse","actual_qty","valuation_rate","stock_value"]',
      'limit_page_length': '*',
      'filters': jsonEncode(filters)
    };
    try {
      final response = await DioHelper.dio?.get(url,
          queryParameters: queryParams,
          options: Options(
            sendTimeout: const Duration(seconds: Sizes.timeoutDuration),
            receiveTimeout: const Duration(seconds: Sizes.timeoutDuration),
          ));
      if (response?.statusCode == 200) {
        var data = response?.data;
        list = data['data'];
        for (var listJson in list) {
          binlist.add(Bin.fromJson(listJson));
        }
        return binlist;
      }
    } catch (e) {
      exception(e, url, 'getBinListFromApi');
    }
    return binlist;
  }

  //for fetching customer list
  Future<List<Bin>> getBinList(
      List<dynamic> filters, ConnectivityStatus connectivityStatus) async {
    var list = [];
    var binlist = <Bin>[];
    var url = '/api/resource/Bin';
    var queryParams = {
      'fields':
          '["name","item_code","modified","warehouse","actual_qty","valuation_rate","stock_value"]',
      'limit_page_length': '*',
      'filters': jsonEncode(filters)
    };
    try {
      // online
      if (connectivityStatus == ConnectivityStatus.cellular ||
          connectivityStatus == ConnectivityStatus.wifi) {
        var data = locator.get<OfflineStorage>().getItem(Strings.bin);
        // contains cached item cached data
        if (data['data'] != null) {
          return await locator
              .get<FetchCachedDoctypeService>()
              .fetchCachedBinData();
        }
        // if cached data is not present load data from api
        else {
          final response = await DioHelper.dio?.get(url,
              queryParameters: queryParams,
              options: Options(
                sendTimeout: const Duration(seconds: Sizes.timeoutDuration),
                receiveTimeout: const Duration(seconds: Sizes.timeoutDuration),
              ));
          if (response?.statusCode == 200) {
            var data = response?.data;
            list = data['data'];
            for (var listJson in list) {
              binlist.add(Bin.fromJson(listJson));
            }
            return binlist;
          } else {
            await showErrorToast(response);
          }
        }
      } else {
        // offline
        return await locator
            .get<FetchCachedDoctypeService>()
            .fetchCachedBinData();
      }
    } catch (e) {
      exception(e, url, 'getBinList');
    }
    return binlist;
  }

  Future<dynamic> getDoc(String? doctype, String? name) async {
    dynamic doctypeMeta;
    var url = '/api/method/frappe.desk.form.load.getdoc';
    var timestamp = DateTime.now().millisecondsSinceEpoch;

    var queryParams = {
      'doctype': doctype,
      'name': name,
      '_': timestamp,
    };
    try {
      // if data is cached then fetch from cache
      var data = locator.get<OfflineStorage>().getItem('$doctype/$name');
      if (data['data'] != null) {
        debugPrint('Fetched from Cache');
        return jsonDecode(data['data']);
      }
      // fetch from api and cache data
      else {
        debugPrint('Fetched from Api');
        final response = await DioHelper.dio?.get(
          url,
          queryParameters: queryParams,
        );

        if (response?.statusCode == 200) {
          doctypeMeta = response?.data;
          await locator
              .get<OfflineStorage>()
              .putItem('$doctype/$name', jsonEncode(doctypeMeta));
          return doctypeMeta;
        }
      }
    } catch (e) {
      exception(e, url, 'getDoc');
    }
    return doctypeMeta;
  }

  Future<dynamic> getDoctype(
    String doctype,
  ) async {
    dynamic doctypeMeta;
    // final url = userFromFullName(fullname);
    var url = '/api/method/frappe.desk.form.load.getdoctype';
    var timestamp = DateTime.now().millisecondsSinceEpoch;

    var queryParams = {
      'doctype': doctype,
      'with_parent': 1,
      '_': timestamp,
    };
    try {
      final response = await DioHelper.dio?.get(
        url,
        queryParameters: queryParams,
      );

      if (response?.statusCode == 200) {
        doctypeMeta = response?.data;
        return doctypeMeta;
      }
    } catch (e) {
      exception(e, url, 'getDoctype');
    }
    return doctypeMeta;
  }

  Future<GlobalDefaults> getGlobalDefaults() async {
    GlobalDefaults gd;
    var url = '/api/resource/Global%20Defaults/Global%20Defaults';

    try {
      final response = await DioHelper.dio?.get(url);

      if (response?.statusCode == 200) {
        gd = GlobalDefaults.fromJson(response?.data['data']);
        return gd;
      }
    } catch (e) {
      exception(e, url, 'getGlobalDefaults');
    }
    return GlobalDefaults();
  }

  Future<dynamic> getFiscalYear() async {
    var url = '/api/method/erpnext.accounts.utils.get_fiscal_year';
    var timestamp = DateTime.now();

    var queryParams = {
      'date': '${timestamp.year}-${timestamp.month}-${timestamp.day}',
      'boolean': false,
    };
    try {
      final response = await DioHelper.dio?.get(
        url,
        queryParameters: queryParams,
      );

      if (response?.statusCode == 200) {
        return response?.data;
      }
    } catch (e) {
      exception(e, url, 'getFiscalYear');
    }
    return null;
  }

  Future<User> getUser(String fullname) async {
    User user;
    // final url = userFromFullName(fullname);
    var url = '/api/resource/User';
    var queryParams = {
      'fields': '["*"]',
      'filters': '[["User","full_name","=","$fullname"]]',
    };
    try {
      final response = await DioHelper.dio?.get(
        url,
        queryParameters: queryParams,
      );

      if (response?.statusCode == 200) {
        user = User.fromJson(response?.data['data'][0]);
        return user;
      }
    } catch (e) {
      exception(e, url, 'getUser');
    }
    return User();
  }

  Future<User> getUserFromEmail(String email) async {
    User user;
    // final url = userFromFullName(fullname);
    var url = '/api/resource/User';
    var queryParams = {
      'fields': '["*"]',
      'filters': '[["User","email","=","$email"]]',
    };
    try {
      final response = await DioHelper.dio?.get(
        url,
        queryParameters: queryParams,
      );
      if (response?.statusCode == 200) {
        user = User.fromJson(response?.data['data'][0]);
        return user;
      }
    } catch (e) {
      exception(e, url, 'getUser');
    }
    return User();
  }

  //for fetching username
  Future<String> getUsername() async {
    var username = '';
    final url = usernameUrl();

    try {
      final response = await DioHelper.dio?.get(url);

      if (response?.statusCode == 200) {
        var data = response?.data;
        username = data['message'];
        return username;
      }
    } catch (e) {
      exception(e, url, 'getUsername');
    }
    return username;
  }

  Future<String> downloadPdf(String doctype, String docname) async {
    var storagePermission = await [
      Permission.storage,
    ].request();
    var queryParams = <String, dynamic>{};
    final pu = pdfUrl();
    // if (defaultPrintFormat == null) {
    queryParams = {
      'doctype': doctype,
      'name': docname,
    };
    // }
    //  else {
    //   queryParams = {
    //     'doctype': doctype,
    //     'name': docname,
    //     'format': defaultPrintFormat,
    //     'no_letterhead': 1,
    //     'letterhead': 'No Letterhead',
    //     'settings': '{}',
    //     '_lang': 'en'
    //   };
    // }

    // /*
    try {
      String fullPath = '';
      if (storagePermission.isNotEmpty) {
        var downpath = '';
        if (defaultTargetPlatform == TargetPlatform.android) {
          var downloadsDirectoryPath = await getApplicationSupportDirectory();
          downpath = downloadsDirectoryPath.path;
        } else {
          var downloadsDirectoryPath = await getApplicationDocumentsDirectory();
          downpath = downloadsDirectoryPath.path;
        }

        // var datetime = DateTime.now();
        // FileUtils.mkdir([downpath]);
        var fileName = '/$docname.pdf';
        fullPath = downpath + fileName;
        // print('full path $fullPath');
        await DioHelper.dio?.download(
          pu,
          fullPath,
          queryParameters: queryParams,
          // onReceiveProgress: showDownloadProgress,
          options: Options(
              responseType: ResponseType.bytes,
              followRedirects: false,
              validateStatus: (status) {
                return status! < 500;
              }),
        );

        return fullPath;
      }
    } catch (e) {
      // exception(e, pu, 'pdfFromDocName');
      if (e is PathExistsException) {
        var downpath = '';
        if (defaultTargetPlatform == TargetPlatform.android) {
          var downloadsDirectoryPath = await getApplicationSupportDirectory();
          downpath = downloadsDirectoryPath.path;
        } else {
          var downloadsDirectoryPath = await getApplicationDocumentsDirectory();
          downpath = downloadsDirectoryPath.path;
        }
        var fullPath = '$downpath/$docname.pdf';
        // for a file
        var isExists = await File(fullPath).exists();
        if (isExists) {
          await OpenFilex.open(fullPath);
        }
      }
    } finally {}
    // */
    return '';
  }

  // get single field data from doctype ie getting item_name list from item doctype
  Future<List<String>> getDoctypeFieldList(
      String url, String field, Map<String, String> queryParams) async {
    var docFieldList = <String>[];
    try {
      queryParams['limit_page_length'] = '*';
      queryParams['fields'] = '["$field"]';

      final response = await DioHelper.dio?.get(
        url,
        queryParameters: queryParams,
      );
      if (response?.statusCode == 200) {
        var data = response?.data;

        var list = data['data'] as List;
        for (var listJson in list) {
          docFieldList.add(listJson[field] as String);
        }
        return docFieldList;
      }
    } catch (e) {
      exception(e, url, 'getDoctypeFieldList', showToast: false);
    }
    return docFieldList;
  }

  Future<dynamic> getWorkflowTransition(var body) async {
    try {
      var headers = {
        'Content-Type': "multipart/form-data",
        "Accept": "application/json",
      };
      final formData = FormData.fromMap({
        'doc': jsonEncode(body),
      });
      var url = '/api/method/frappe.model.workflow.get_transitions';
      final response = await DioHelper.dio
          ?.post(url, data: formData, options: Options(headers: headers));

      var finalData = json.decode(response.toString());
      if (finalData != null && response!.statusCode == 200) {
        return {'success': true, 'message': finalData['message']};
      } else {
        return {'success': false, 'data': finalData};
      }
    } catch (e) {
      exception(e, '/api/method/frappe.model.workflow.get_transitions',
          'getWorkflowTransition',
          showToast: false);
    }
  }

  Future<dynamic> applyWorkflowTransition(var body, String action) async {
    try {
      var headers = {
        'Content-Type': "multipart/form-data",
        "Accept": "application/json",
      };
      var url = '/api/method/frappe.model.workflow.apply_workflow';

      final formData =
          FormData.fromMap({'doc': jsonEncode(body), 'action': action});
      final response = await DioHelper.dio?.post(
        url,
        data: formData,
        options: Options(headers: headers),
      );
      var finalData = json.decode(response.toString());
      if (finalData != null && response!.statusCode == 200) {
        return {'success': true, 'message': finalData['message']};
      } else {
        return {'success': false, 'data': finalData};
      }
    } catch (e) {
      exception(e, '/api/method/frappe.model.workflow.apply_workflow',
          'applyWorkflowTransition',
          showToast: false);
    }
  }

  Future<dynamic> searchLink(
      String? doctype, Map<String, dynamic> filters) async {
    var url = '/api/method/frappe.desk.search.search_link';
    var timestamp = DateTime.now().millisecondsSinceEpoch;

    var queryParams = {
      'doctype': doctype,
      'txt': '',
      'filters': jsonEncode(filters),
      '_': timestamp,
    };
    try {
      final response = await DioHelper.dio?.get(
        url,
        queryParameters: queryParams,
      );

      if (response?.statusCode == 200) {
        return response?.data;
      }
    } catch (e) {
      exception(e, url, 'searchLink');
    }
    return null;
  }
}
