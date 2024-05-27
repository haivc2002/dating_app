import 'package:dating/common/global.dart';
import 'package:dating/theme/theme_color.dart';
import 'package:flutter/material.dart';

class ThemeSystem {
  static Color systemTheme = Global.getBool('theme') ? ThemeColor.themeDarkSystem : ThemeColor.themeLightSystem;
  static Color systemThemeFade = Global.getBool('theme') ? ThemeColor.themeDarkFadeSystem : ThemeColor.themeLightFadeSystem;
  static Color systemText = Global.getBool('theme') ? ThemeColor.whiteColor : ThemeColor.blackNotAbsolute;

  static void updateTheme() {
    systemTheme = Global.getBool('theme') ? ThemeColor.themeDarkSystem : ThemeColor.themeLightSystem;
    systemThemeFade = Global.getBool('theme') ? ThemeColor.themeDarkFadeSystem : ThemeColor.themeLightFadeSystem;
    systemText = Global.getBool('theme') ? ThemeColor.whiteColor : ThemeColor.blackNotAbsolute;
  }
}