import 'package:ampower_buzzit_mobile/common/service/storage_service.dart';
import 'package:ampower_buzzit_mobile/locator/locator.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;
  static String? cookies;
  static var storageService = locator.get<StorageService>();

  static Future init(String baseUrl) async {
    var cookieJar = await getCookiePath();
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
      ),
    )..interceptors.add(
        CookieManager(cookieJar),
      );
    dio?.options.connectTimeout = const Duration(seconds: 60);
    dio?.options.receiveTimeout = const Duration(seconds: 60);
  }

  static Future initCookies() async {
    cookies = await getCookies();
  }

  static Future<PersistCookieJar> getCookiePath() async {
    var appDocDir = await getApplicationSupportDirectory();
    var appDocPath = appDocDir.path;
    // print(appDocPath);
    return PersistCookieJar(
        ignoreExpires: true, storage: FileStorage(appDocPath));
  }

  Future<bool> signOut() async {
    storageService.loggedIn = false;
    return true;
  }

  static Future<String?> getCookies() async {
    var cookieJar = await getCookiePath();
    var baseurl = locator.get<StorageService>().apiUrl;
    var cookies = await cookieJar.loadForRequest(Uri.parse(baseurl));

    var cookie = CookieManager.getCookies(cookies);

    return cookie;
  }

  static Future initApiConfig() async {
    var baseUrl = locator.get<StorageService>().apiUrl;
    await DioHelper.init(baseUrl);
    await DioHelper.initCookies();
  }
}
