import 'package:dating/common/textstyles.dart';
import 'package:dating/theme/theme_system.dart';
import 'package:dating/tool_widget_custom/item_card.dart';
import 'package:dating/ui/about_app/about_app_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/global.dart';

class SettingScreen extends StatefulWidget {
  static const String routeName = 'settingScreen';
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  bool isDarkMode = Global.getBool('theme', def: false);

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
      Global.setBool('theme', isDarkMode);
      ThemeSystem.updateTheme();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      color: ThemeSystem.systemTheme,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Container(
              height: 120.w,
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  IconButton(onPressed: () => Navigator.pop(context), icon: Icon(CupertinoIcons.back, color: ThemeSystem.systemText,)),
                  SizedBox(width: 10.w),
                  Text('Setting', style: TextStyles.defaultStyle.bold.appbarTitle)
                ],
              ),
            ),
            item()
          ],
        ),
      ),
    );
  }

  Widget item() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          cartAnimate(
            Text(isDarkMode ? 'Light mode' : 'Dark mode'),
            IconButton(onPressed: toggleTheme,
              icon: AnimatedCrossFade(
                duration: const Duration(milliseconds: 300),
                firstChild: const Icon(Icons.dark_mode, key: ValueKey('light')),
                secondChild: const Icon(Icons.light_mode, key: ValueKey('dark'), color: Colors.white,),
                crossFadeState: isDarkMode ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              ),
            ),
            () => toggleTheme(),
          ),
          cartAnimate(
            const Text('Account'),
            Text('data', style: TextStyles.defaultStyle.setColor(ThemeSystem.systemText)),
            () => Navigator.pushNamed(context, AboutAppScreen.routeName),
          ),
          cartAnimate(
            const Text('About application'),
            Icon(Icons.arrow_forward_ios, size: 15.sp, color: ThemeSystem.systemText),
            () => toggleTheme,
          ),
        ],
      ),
    );
  }

  Widget cartAnimate(Widget widgetStart, Widget widgetEnd, Function() onTap ) {
    return AnimatedContainer(
      height: 70.w,
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
          color: ThemeSystem.systemThemeFade,
          borderRadius: BorderRadius.circular(10.w)
      ),
      margin: EdgeInsets.only(
          bottom: 15.w
      ),
      padding: EdgeInsets.all(10.w),
      child: ListTile(
        onTap: onTap,
        leading: AnimatedDefaultTextStyle(style: TextStyle(color: ThemeSystem.systemText), duration: const Duration(milliseconds: 300), child: widgetStart),
        trailing: widgetEnd,
      )
    );
  }
}
