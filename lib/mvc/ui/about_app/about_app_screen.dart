import 'dart:ui';

import 'package:dating/common/scale_screen.dart';
import 'package:dating/common/textstyles.dart';
import 'package:dating/theme/theme_color.dart';
import 'package:dating/tool_widget_custom/appbar_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rive/rive.dart';

class AboutAppScreen extends StatefulWidget {
  static const String routeName = 'aboutAppScreen';
  const AboutAppScreen({Key? key}) : super(key: key);

  @override
  State<AboutAppScreen> createState() => _AboutAppScreenState();
}

class _AboutAppScreenState extends State<AboutAppScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: heightScreen(context),
            child: const RiveAnimation.asset(
              'assets/rive/magic_plant.riv',
              fit: BoxFit.cover,
            ),
          ),
          AppBarCustom(
            title: 'About app',
            textStyle: TextStyles.defaultStyle.bold.appbarTitle,
            scrollPhysics: const NeverScrollableScrollPhysics(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                const Spacer(flex: 2),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.w),
                  child: Container(
                    color: ThemeColor.whiteColor.withOpacity(0.7),
                    height: 150.w,
                    width: widthScreen(context),
                    child: ClipRRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaY: 8, sigmaX: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('DASH DATE', style: TextStyles.defaultStyle.bold.setTextSize(25.sp).setColor(ThemeColor.deepRedColor)),
                            Text('version: 6.2418.0', style: TextStyles.defaultStyle)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Text('Copyright 2024-2025 Dash Date Software, protected', style: TextStyles.defaultStyle.bold.setColor(ThemeColor.whiteColor), textAlign: TextAlign.center),
                SizedBox(height: 30.w)
              ],
            ),
          )
        ],
      ),
    );
  }
}
