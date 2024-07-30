import 'package:flutter/material.dart';

class ThemeColor {
  static const Color themeDarkSystem = Color(0xFF2B2B2B);
  static const Color themeDarkFadeSystem = Color(0xFF343434);
  static const Color themeLightSystem = Color(0xFFFFFDF7);
  static const Color themeLightFadeSystem = Color(0xFFE5E5E5);


  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color whiteIos = Color(0xFFE8E8E8);
  static const Color blackColor = Color(0xFF000000);
  static const Color pinkColor = Color(0xFFFF6880);
  static const Color pinkFadeColor = Color(0xFFF38F9F);
  static const Color redColor = Colors.red;
  static const Color deepRedColor = Color(0xFFC8001A);
  static const Color greyColor = Color(0xFF9C9C9C);
  static const Color greyFadeColor = Color(0xFFCFCDC9);
  static const Color blueColor = Color(0xFF2378DC);
  static const Color blackNotAbsolute = Color(0xFF18191A);
  static const Color yellowColor = Colors.yellow;
  static const Color orangeFadeColor = Color(0xFFF3A332);
  static const Color golderColor = Color(0xFFEB9D26);
  static const Color golderFadeColor = Color(0xFFF7D678);

}

class ColorPaletteProvider extends InheritedWidget {
  final ThemeColor themeColor;

  const ColorPaletteProvider({
    Key? key,
    required Widget child,
    required this.themeColor,
  }) : super(key: key, child: child);

  static ColorPaletteProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ColorPaletteProvider>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}
