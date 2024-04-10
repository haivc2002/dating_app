import 'package:flutter/cupertino.dart';

class ThemeColor {
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color blackColor = Color(0xFF000000);
  static const Color pinkColor = Color(0xFFF28F9E);
  static const Color backgroundScaffold = Color(0xFF2B2B2B);
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