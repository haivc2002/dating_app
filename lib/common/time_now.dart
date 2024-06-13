import 'package:dating/theme/theme_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimeNow {
  static String helloDate() {
    DateTime now = DateTime.now();
    int hour = now.hour;

    if (hour < 12) {
      return 'Good morning';
    } else if (hour < 18) {
      return 'Good afternoon';
    } else {
      return 'Good evening';
    }
  }
  
  static Widget iconDate() {
    DateTime now = DateTime.now();
    int hour = now.hour;

    if (hour < 12) {
      return const Icon(Icons.sunny_snowing, color: ThemeColor.orangeFadeColor,);
    } else if (hour < 18) {
      return const Icon(CupertinoIcons.sun_max_fill, color: ThemeColor.yellowColor,);
    } else {
      return const Icon(CupertinoIcons.moon_fill, color: ThemeColor.whiteColor,);
    }
  }
}