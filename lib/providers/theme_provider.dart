import 'package:flutter/material.dart';
import 'package:glp/theme/theme.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = Brightness.dark ==
          WidgetsBinding.instance.platformDispatcher.platformBrightness
      ? darkMode
      : lightMode;

  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
}
