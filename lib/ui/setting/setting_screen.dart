import 'package:dating/theme/theme_system.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
      body: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 120.w,
            color: ThemeSystem.systemTheme,
          ),
          item()
        ],
      ),
    );
  }

  Widget item() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          Row(
            children: [
              Text(isDarkMode ? 'Light mode' : 'Dark mode'),
              const Spacer(),
              IconButton(onPressed: toggleTheme,
                icon: AnimatedCrossFade(
                  duration: const Duration(milliseconds: 300),
                  firstChild: const Icon(Icons.dark_mode, key: ValueKey('light')),
                  secondChild: const Icon(Icons.light_mode, key: ValueKey('dark')),
                  crossFadeState: isDarkMode ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
