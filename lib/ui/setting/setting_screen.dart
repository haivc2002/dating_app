import 'package:dating/common/textstyles.dart';
import 'package:dating/theme/theme_color.dart';
import 'package:dating/ui/about_app/about_app_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../common/global.dart';
import '../../theme/theme_notifier.dart';

class SettingScreen extends StatefulWidget {
  static const String routeName = 'settingScreen';
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late ThemeNotifier themeNotifier;
  bool isDarkMode = Global.getBool('theme', def: false);
  double currentDistance = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    themeNotifier = Provider.of<ThemeNotifier>(context);
  }

  // void toggleTheme() {
  //   setState(() {
  //     isDarkMode = !isDarkMode;
  //     Global.setBool('theme', isDarkMode);
  //     ThemeSystem.updateTheme();
  //     themeNotifier.toggleTheme();
  //   });
  // }
  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
      Global.setBool('theme', isDarkMode);
      Provider.of<ThemeNotifier>(context, listen: false).toggleTheme();
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      color: themeNotifier.systemTheme,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Container(
              height: 120.w,
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(CupertinoIcons.back, color: themeNotifier.systemText),
                  ),
                  SizedBox(width: 10.w),
                  Text('Setting', style: TextStyles.defaultStyle.bold.appbarTitle),
                ],
              ),
            ),
            item(),
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
            IconButton(
              onPressed: toggleTheme,
              icon: AnimatedCrossFade(
                duration: const Duration(milliseconds: 300),
                firstChild: const Icon(Icons.dark_mode, key: ValueKey('light')),
                secondChild: const Icon(Icons.light_mode, key: ValueKey('dark'), color: Colors.white),
                crossFadeState: isDarkMode ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              ),
            ),
                () => toggleTheme(),
          ),
          cartAnimate(
            const Text('Account'),
            Text('data', style: TextStyles.defaultStyle.setColor(themeNotifier.systemText)),
                () => Navigator.pushNamed(context, AboutAppScreen.routeName),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: themeNotifier.systemThemeFade,
              borderRadius: BorderRadius.circular(10.w),
            ),
            margin: EdgeInsets.only(bottom: 15.w),
            padding: EdgeInsets.all(10.w),
            child: ListTile(
              title: Text('${currentDistance.round()}km', style: TextStyles.defaultStyle.setColor(themeNotifier.systemText)),
              subtitle: Slider(
                activeColor: ThemeColor.pinkColor,
                value: currentDistance,
                min: 1,
                max: 20,
                divisions: 19,
                onChanged: (value) {
                  setState(() {
                    currentDistance = value;
                  });
                },
              ),
            ),
          ),
          cartAnimate(
            const Text('About application'),
            Icon(Icons.arrow_forward_ios, size: 15.sp, color: themeNotifier.systemText),
                () => Navigator.pushNamed(context, AboutAppScreen.routeName),
          ),
        ],
      ),
    );
  }

  Widget cartAnimate(Widget widgetStart, Widget widgetEnd, Function() onTap) {
    return AnimatedContainer(
      height: 70.w,
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: themeNotifier.systemThemeFade,
        borderRadius: BorderRadius.circular(10.w),
      ),
      margin: EdgeInsets.only(bottom: 15.w),
      padding: EdgeInsets.all(10.w),
      child: ListTile(
        onTap: onTap,
        leading: AnimatedDefaultTextStyle(
          style: TextStyle(color: themeNotifier.systemText),
          duration: const Duration(milliseconds: 300),
          child: widgetStart,
        ),
        trailing: widgetEnd,
      ),
    );
  }
}
