import 'dart:ui';

import 'package:dating/common/scale_screen.dart';
import 'package:dating/common/textstyles.dart';
import 'package:dating/theme/theme_color.dart';
import 'package:dating/tool_widget_custom/appbar_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

import '../../theme/theme_notifier.dart';

class AboutAppScreen extends StatefulWidget {
  static const String routeName = 'aboutAppScreen';
  const AboutAppScreen({Key? key}) : super(key: key);

  @override
  State<AboutAppScreen> createState() => _AboutAppScreenState();
}

class _AboutAppScreenState extends State<AboutAppScreen> {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Scaffold(
      backgroundColor: themeNotifier.systemTheme,
      body: Stack(
        children: [
          AppBarCustom(
            title: 'About app',
            textStyle: TextStyles.defaultStyle.bold.appbarTitle,
            scrollPhysics: const NeverScrollableScrollPhysics(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                const Spacer(),
                Text('DASH DATE', style: TextStyles.defaultStyle.bold.setTextSize(25.sp).setColor(ThemeColor.deepRedColor)),
                Text('version: 6.2418.0', style: TextStyles.defaultStyle.setColor(themeNotifier.systemText)),
                const Spacer(),
                Text('Copyright 2024-2025 Dash Date Software, protected', style: TextStyles.defaultStyle.bold.setColor(themeNotifier.systemText), textAlign: TextAlign.center),
                SizedBox(height: 30.w)
              ],
            ),
          )
        ],
      ),
    );
  }
}
