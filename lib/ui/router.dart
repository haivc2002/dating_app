import 'package:flutter/cupertino.dart';

import 'all_tap_bottom/all_tap_bottom_screen.dart';
import 'auth/login_screen.dart';

class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {

      case LoginScreen.routeName:
        return CupertinoPageRoute(builder: (_) => const LoginScreen());

      case AllTapBottomScreen.routeName:
        return CupertinoPageRoute(builder: (_) => const AllTapBottomScreen());

      default:
        return null;
    }
  }
}