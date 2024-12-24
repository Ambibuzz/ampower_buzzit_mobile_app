import 'dart:convert';
import 'package:ampower_buzzit_mobile/base_viewmodel.dart';
import 'package:ampower_buzzit_mobile/common/service/offline_storage_service.dart';
import 'package:ampower_buzzit_mobile/config/exception.dart';
import 'package:ampower_buzzit_mobile/locator/locator.dart';
import 'package:ampower_buzzit_mobile/model/comment.dart';
import 'package:ampower_buzzit_mobile/model/purchase_order.dart';
import 'package:ampower_buzzit_mobile/service/api_service.dart';
import 'package:ampower_buzzit_mobile/util/apiurls.dart';
import 'package:ampower_buzzit_mobile/util/constants/strings.dart';
import 'package:ampower_buzzit_mobile/util/dio_helper.dart';
import 'package:ampower_buzzit_mobile/util/enums.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PurchaseOrderDetailViewModel extends BaseViewModel {
  PurchaseOrder po = PurchaseOrder();
  List<dynamic> workflow_actions = [];
  Map<dynamic, dynamic> workflow = {};
  Map<dynamic, dynamic> payload = {};
  List<Comment> comments = [];
  TextEditingController addCommentController = TextEditingController();

  clearText() {
    addCommentController.clear();
    notifyListeners();
  }

  Future getTransitionState() async {
    workflow_actions.clear();
    workflow = await locator.get<ApiService>().getWorkflowTransition(payload);
    if (workflow['success'] == true) {
      Set<String> seenActions = {};
      for (int i = 0; i < workflow['message'].length; i++) {
        String action = workflow['message'][i]['action'];
        if (!seenActions.contains(action)) {
          seenActions.add(action);
          workflow_actions.add({
            'action': action,
            'next_state': workflow['message'][i]['next_state']
          });
        }
      }
    }

    notifyListeners();
  }

  Future getPurchaseOrder(
      String doctype, String name, ConnectivityStatus connectivityStatus) async {
    setState(ViewState.busy);
    final cu = doctypeDetailUrl(doctype, name);
    comments.clear();
    try {
      if (connectivityStatus == ConnectivityStatus.cellular ||
          connectivityStatus == ConnectivityStatus.wifi) {
        // online
        final response = await locator.get<ApiService>().getDoc(doctype, name);
        if (response != null) {
          payload = response['docs'][0];
          po = PurchaseOrder.fromJson(response['docs'][0]);
          var commentsList = response['docinfo']['comments'] as List;
          for (var commentJson in commentsList) {
            comments.add(Comment.fromJson(commentJson));
          }
        }
      } else {
        var data = locator.get<OfflineStorage>().getItem(Strings.purchaseOrder);
        var sodata = jsonDecode(data['data']);
        if (sodata != null) {
          var solist = PurchaseOrderList.fromJson(sodata);
          if (solist.purchaseOrderList != null) {
            po = solist.purchaseOrderList!.firstWhere((e) => e.name == name);
          }
        }
      }
      notifyListeners();
    } catch (e) {
      exception(e, cu, 'getPurchaseOrder');
    } finally {
      setState(ViewState.idle);
    }
    setState(ViewState.idle);
  }
}
