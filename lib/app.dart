import 'dart:io';

import 'package:ampower_buzzit_mobile/app_viewmodel.dart';
import 'package:ampower_buzzit_mobile/base_view.dart';
import 'package:ampower_buzzit_mobile/common/service/connectivity_service.dart';
import 'package:ampower_buzzit_mobile/common/service/dialog_manager.dart';
import 'package:ampower_buzzit_mobile/common/service/navigation_service.dart';
import 'package:ampower_buzzit_mobile/common/service/storage_service.dart';
import 'package:ampower_buzzit_mobile/config/exception.dart';
import 'package:ampower_buzzit_mobile/config/theme.dart';
import 'package:ampower_buzzit_mobile/config/theme_model.dart';
import 'package:ampower_buzzit_mobile/lifecycle_manager.dart';
import 'package:ampower_buzzit_mobile/locator/locator.dart';
import 'package:ampower_buzzit_mobile/route/routing_constants.dart';
import 'package:ampower_buzzit_mobile/util/enums.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:flutter_upgrade_version/flutter_upgrade_version.dart';
import 'package:provider/provider.dart';
import 'route/router.dart' as router;

class App extends StatefulWidget {
  final bool? login;
  App({this.login, Key? key}) : super(key: key);
  static var storageService = locator.get<StorageService>();

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  var _packageInfo = PackageInfo();

  @override
  void initState() {
    super.initState();
    getPackageData();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> getPackageData() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    _packageInfo = await PackageManager.getPackageInfo();
    // Locale myLocale = Localizations.localeOf(context);
    // print('LOCALE: ${myLocale.languageCode} || ${myLocale.countryCode}');
    if (Platform.isAndroid) {
      var manager = InAppUpdateManager();
      var appUpdateInfo = await manager.checkForUpdate();
      if (appUpdateInfo == null) return;
      if (appUpdateInfo.updateAvailability ==
          UpdateAvailability.developerTriggeredUpdateInProgress) {
        //If an in-app update is already running, resume the update.
        var message =
            await manager.startAnUpdate(type: AppUpdateType.immediate);
        debugPrint(message ?? '');
      } else if (appUpdateInfo.updateAvailability ==
          UpdateAvailability.updateAvailable) {
        ///Update available
        if (appUpdateInfo.immediateAllowed) {
          var message =
              await manager.startAnUpdate(type: AppUpdateType.immediate);
          debugPrint(message ?? '');
        } else if (appUpdateInfo.flexibleAllowed) {
          var message =
              await manager.startAnUpdate(type: AppUpdateType.flexible);
          debugPrint(message ?? '');
        } else {
          debugPrint(
              'Update available. Immediate & Flexible Update Flow not allow');
        }
      }
    } else if (Platform.isIOS) {
      var _versionInfo = await UpgradeVersion.getiOSStoreVersion(
        packageInfo: _packageInfo,
      );
      debugPrint(_versionInfo.toJson().toString());
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<AppViewModel>(
      onModelReady: (model) async {},
      builder: (context, model, child) {
        return LifeCycleManager(
          child: StreamProvider<ConnectivityStatus>(
            initialData: ConnectivityStatus.wifi,
            create: (context) => locator
                .get<ConnectivityService>()
                .connectivityStatusController
                .stream,
            child: MultiProvider(
              providers: [
                ChangeNotifierProvider<ThemeModel>(
                  create: (_) => ThemeModel(),
                ),
              ],
              child: Consumer(
                builder: (context, ThemeModel themeNotifier, _) {
                  bool? isDark = themeNotifier.isDark;

                  // var theme = isDark
                  //     ? CustomTheme.darkTheme(
                  //         primaryColor:
                  //             targetitHomeViewModelLocator.primaryColor ??
                  //                 CustomTheme.primaryColorDark)
                  //     : CustomTheme.lightTheme(
                  //         primaryColor:
                  //             targetitHomeViewModelLocator.primaryColor ??
                  //                 CustomTheme.primaryColorLight);

                  return Portal(
                    child: MaterialApp(
                      title: 'BuzzIT',
                      onGenerateRoute: router.generateRoute,
                      navigatorKey:
                          locator.get<NavigationService>().navigatorKey,
                      builder: (context, widget) => Navigator(
                        onGenerateRoute: (settings) => MaterialPageRoute(
                          builder: (context) => DialogManager(
                            child: MediaQuery(
                                data: MediaQuery.of(context)
                                    .copyWith(textScaleFactor: 1.0),
                                child: widget ?? const SizedBox.shrink()),
                          ),
                        ),
                      ),
                      initialRoute: (widget.login == true
                          ?
                          //  homeViewRoute
                          splashViewRoute
                          : loginViewRoute),
                      debugShowCheckedModeBanner: false,
                      theme: CustomTheme.lightTheme(),
                      // theme: CustomTheme.lightTheme(),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
