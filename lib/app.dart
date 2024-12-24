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
import 'package:new_version_plus/new_version_plus.dart';
import 'package:provider/provider.dart';
import 'route/router.dart' as router;

class App extends StatelessWidget {
  final bool? login;
  App({this.login, Key? key}) : super(key: key);
  static var storageService = locator.get<StorageService>();

  void basicStatusCheck(NewVersionPlus newVersion, BuildContext context) {
    try {
      if (!kDebugMode) {
        newVersion.showAlertIfNecessary(context: context);
      }
    } catch (e) {
      exception(e, '', 'basicStatusCheck');
    }
  }

  void advancedStatusCheck(
      NewVersionPlus newVersion, BuildContext context) async {
    try {
      final status = await newVersion.getVersionStatus();
      if (status != null) {
        debugPrint(status.releaseNotes);
        debugPrint(status.appStoreLink);
        debugPrint(status.localVersion);
        debugPrint(status.storeVersion);
        debugPrint(status.canUpdate.toString());
        newVersion.showUpdateDialog(
          context: context,
          versionStatus: status,
          dialogTitle: 'Custom Title',
          dialogText: 'Custom Text',
        );
      }
    } catch (e) {
      exception(e, '', 'advancedStatusCheck');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<AppViewModel>(
      onModelReady: (model) async {
        // await model.setPrimaryColor();
        final newVersion = NewVersionPlus();
        basicStatusCheck(newVersion, context);
      },
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
                      initialRoute: (login == true
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
