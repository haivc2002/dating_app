import 'package:dating/theme/theme_color.dart';
import 'package:flutter/material.dart';

import '../common/global.dart';

class ThemeNotifier with ChangeNotifier {
  bool _isDarkMode = Global.getBool('theme');

  bool get isDarkMode => _isDarkMode;

  Color get systemTheme => _isDarkMode ? ThemeColor.themeDarkSystem : ThemeColor.themeLightSystem;
  Color get systemThemeFade => _isDarkMode ? ThemeColor.themeDarkFadeSystem : ThemeColor.themeLightFadeSystem;
  Color get systemText => _isDarkMode ? ThemeColor.whiteColor : ThemeColor.blackNotAbsolute;

  Color get highlight => _isDarkMode ? ThemeColor.themeLightFadeSystem : ThemeColor.themeDarkFadeSystem;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    Global.setBool('theme', _isDarkMode);
    notifyListeners();
  }
}