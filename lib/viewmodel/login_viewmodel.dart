import 'package:ampower_buzzit_mobile/base_viewmodel.dart';
import 'package:ampower_buzzit_mobile/common/service/login_api_service.dart';
import 'package:ampower_buzzit_mobile/common/service/storage_service.dart';
import 'package:ampower_buzzit_mobile/locator/locator.dart';
import 'package:ampower_buzzit_mobile/util/enums.dart';
import 'package:package_info_plus/package_info_plus.dart';

class LoginViewModel extends BaseViewModel {
  String version = '';

  void getVersion() async {
    var packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    notifyListeners();
  }

  Future<String> getUsername() async {
    var username = locator.get<StorageService>().userName;
    return username;
  }

  Future login(String baseurl, String username, String password) async {
    setState(ViewState.busy);
    await locator.get<LoginService>().login(
          baseUrl: baseurl,
          password: password,
          username: username,
        );
    setState(ViewState.idle);
  }

  Future<String> getInstanceUrl() async {
    var instanceUrl = locator.get<StorageService>().apiUrl;
    return instanceUrl;
  }
}
