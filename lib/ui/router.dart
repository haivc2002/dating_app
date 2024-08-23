import 'package:dating/ui/auth/register_screen.dart';
import 'package:dating/ui/detail/detail_screen.dart';
import 'package:dating/ui/message/view_chat_screen.dart';
import 'package:dating/ui/setting/setting_screen.dart';
import 'package:flutter/cupertino.dart';

import 'about_app/about_app_screen.dart';
import 'auth/register_info_screen.dart';
import 'profile/edit_more_info_screen.dart';
import 'profile/edit_profile_screen.dart';
import 'all_tap_bottom/all_tap_bottom_screen.dart';
import 'auth/login_screen.dart';

class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {

      case LoginScreen.routeName:
        return CupertinoPageRoute(builder: (_) => const LoginScreen());

      case RegisterScreen.routeName:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => const RegisterScreen()
        );

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
        return CupertinoPageRoute(builder: (_) => const EditMoreInfoScreen());

      case SettingScreen.routeName:
        return CupertinoPageRoute(builder: (_) => const SettingScreen());

      case AboutAppScreen.routeName:
        return CupertinoPageRoute(builder: (_) => const AboutAppScreen());

      case DetailScreen.routeName:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) => const DetailScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );

      case RegisterInfoScreen.routeName:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => const RegisterInfoScreen()
        );

      case ViewChatScreen.routeName:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) => const ViewChatScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.fastEaseInToSlowEaseOut;

            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );

      default:
        return null;
    }
  }
}