import 'dart:async';
import 'package:ampower_buzzit_mobile/app.dart';
import 'package:ampower_buzzit_mobile/common/service/storage_service.dart';
import 'package:ampower_buzzit_mobile/config/exception.dart';
import 'package:ampower_buzzit_mobile/locator/locator.dart';
import 'package:ampower_buzzit_mobile/util/helpers.dart';
import 'package:ampower_buzzit_mobile/util/preference.dart';
import 'package:camera/camera.dart';
import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'util/dio_helper.dart';

late List<CameraDescription> cameras;

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
    await setUpLocator();
    await initDb();
    await DioHelper.initApiConfig();
    bool? login = false;
    login = await locator
        .get<StorageService>()
        .getBool(PreferenceVariables.loggedIn);

    runApp(BetterFeedback(
      mode: FeedbackMode.navigate,
      child: App(login: login),
    ));
  } catch (e) {
    exception(e, '', 'main');
  }
}
