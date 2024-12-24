//theme_model.dart
import 'package:ampower_buzzit_mobile/common/service/storage_service.dart';
import 'package:ampower_buzzit_mobile/locator/locator.dart';
import 'package:flutter/material.dart';

class ThemeModel extends ChangeNotifier {
  bool _isDark = false;
  bool get isDark => _isDark;
  ThemeData? theme;


  ThemeModel() {
    _isDark = false;
    getPreferences();
  }

  //Switching theme
  set isDark(bool value) {
    _isDark = value;
    locator.get<StorageService>().theme = value;

    notifyListeners();
  }

  void getPreferences() async {
    _isDark = locator.get<StorageService>().theme;
    notifyListeners();
  }

  //Switching themes 
  void setTheme(ThemeData value) {
    theme = value;
    notifyListeners();
  }
}
