
import 'package:ampower_buzzit_mobile/common/service/navigation_service.dart';
import 'package:ampower_buzzit_mobile/common/service/storage_service.dart';
import 'package:ampower_buzzit_mobile/locator/locator.dart';
import 'package:ampower_buzzit_mobile/route/routing_constants.dart';
import 'package:ampower_buzzit_mobile/util/preference.dart';
import 'package:flutter/material.dart';

//LogoutApiService class contains function for fetching data or posting  data
class LogoutService {
  Future logOut(BuildContext context) async {
    var storageService = locator.get<StorageService>();
    // var baseurl = storageService.apiUrl;
    // var cookie = await DioHelper.getCookiePath();
    // cookie.delete(Uri.parse(baseurl));
    storageService.loggedIn = false;
    storageService.removeCookie = PreferenceVariables.cookie;
    storageService.removeName = PreferenceVariables.name;
    storageService.removeCompany = PreferenceVariables.company;
    storageService.removeUserName = PreferenceVariables.userName;
    storageService.isUserCustomer = false;
    locator.get<StorageService>().isLoginChanged = true;
    // clearAllAndNavigateTo(context, Login());
    await locator
        .get<NavigationService>()
        .pushNamedAndRemoveUntil(loginViewRoute, (_) => false);
  }
}