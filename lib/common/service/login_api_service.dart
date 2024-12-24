import 'package:ampower_buzzit_mobile/common/service/navigation_service.dart';
import 'package:ampower_buzzit_mobile/common/service/storage_service.dart';
import 'package:ampower_buzzit_mobile/common/widgets/custom_toast.dart';
import 'package:ampower_buzzit_mobile/config/exception.dart';
import 'package:ampower_buzzit_mobile/locator/locator.dart';
import 'package:ampower_buzzit_mobile/route/routing_constants.dart';
import 'package:ampower_buzzit_mobile/util/dio_helper.dart';
import 'package:ampower_buzzit_mobile/util/preference.dart';
import 'package:dio/dio.dart';

//LoginApiService class contains function login
class LoginService {
  //For doing login based on the username and password
  Future login(
      {required String username,
      required String password,
      required String baseUrl}) async {
    const url = '/api/method/login';

    try {
      await DioHelper.init(baseUrl);
      final response = await DioHelper.dio?.post(
        url,
        data: {'usr': username, 'pwd': password},
        options: Options(
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      if (response?.statusCode == 200) {
        var storageService = locator.get<StorageService>();
        // var data = jsonDecode(response.body);
        var data = response?.data;
        String fullname = data['full_name'];
        storageService.apiUrl = baseUrl;
        await DioHelper.init(baseUrl);
        await DioHelper.initCookies();
        storageService.userName = username;
        storageService.loggedIn = true;
        storageService.name = fullname;
        await storageService.setBool(PreferenceVariables.loggedIn, true);

        var cookie = response!.headers.map['set-cookie'];
        var cookieString = cookie!.first.toString();
        var cookieSid = cookieString.split(';')[0];
        storageService.cookie = cookieSid;
        locator.get<NavigationService>().pushReplacementNamed(homeViewRoute);
      } else {
        await showErrorToast(response);
      }
    } catch (e) {
      exception(e, url, 'login');
    }
  }
}
