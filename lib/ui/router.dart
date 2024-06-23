import 'package:dating/ui/auth/register_screen.dart';
import 'package:dating/ui/setting/setting_screen.dart';
import 'package:flutter/cupertino.dart';

import 'about_app/about_app_screen.dart';
import 'all_tap_bottom/all_tap/profile/additional_screen/select_height_person.dart';
import 'all_tap_bottom/all_tap/profile/additional_screen/set_hometown.dart';
import 'all_tap_bottom/all_tap/profile/edit_more_info_screen.dart';
import 'all_tap_bottom/all_tap/profile/edit_profile_screen.dart';
import 'all_tap_bottom/all_tap_bottom_screen.dart';
import 'auth/login_screen.dart';

class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {

      case LoginScreen.routeName:
        return CupertinoPageRoute(builder: (_) => const LoginScreen());

      case RegisterScreen.routeName:
        return CupertinoPageRoute(builder: (_) => const RegisterScreen());

      case AllTapBottomScreen.routeName:
        return CupertinoPageRoute(builder: (_) => const AllTapBottomScreen());

      case EditProfileScreen.routeName:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const EditProfileScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );

      case EditMoreInfoScreen.routeName:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const EditMoreInfoScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );

      case SelectHeightPerson.routeName:
        return PageRouteBuilder(
          opaque: false,
          pageBuilder: (BuildContext context, _, __) {
            return const SelectHeightPerson();
          },
        );

      case SetHomeTown.routeName:
        return PageRouteBuilder(
          opaque: false,
          pageBuilder: (BuildContext context, _, __) {
            return const SetHomeTown();
          },
        );

      case SettingScreen.routeName:
        return CupertinoPageRoute(builder: (_) => const SettingScreen());

      case AboutAppScreen.routeName:
        return CupertinoPageRoute(builder: (_) => const AboutAppScreen());

      default:
        return null;
    }
  }
}