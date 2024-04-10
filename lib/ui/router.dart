import 'package:flutter/cupertino.dart';

import 'auth/login_screen.dart';

class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {

      case LoginScreen.routeName:
        return CupertinoPageRoute(builder: (_) => LoginScreen());

      default:
        return null;
    }
  }
}