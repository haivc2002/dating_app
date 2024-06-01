import 'package:dating/theme/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../common/textstyles.dart';

class HeroCustom extends StatelessWidget {
  final Widget? widget;
  final IconData? iconLeading;
  final String? title, data;
  final dynamic keyHero;
  const HeroCustom({
    Key? key,
    this.widget,
    this.iconLeading,
    this.title,
    this.data,
    this.keyHero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Hero(
      tag: keyHero ?? 'keyHero',
      child: Material(
        color: themeNotifier.systemThemeFade,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.w, horizontal: 20.w),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(iconLeading, color: themeNotifier.systemText.withOpacity(0.4)),
                    SizedBox(width: 10.w),
                    Material(color: Colors.transparent, child: Text(title??"", style: TextStyles.defaultStyle.bold.setColor(themeNotifier.systemText))),
                    const Spacer(),
                    Material(color: Colors.transparent, child: Text(data??"", style: TextStyles.defaultStyle.setColor(themeNotifier.systemText))),
                  ],
                ),
                widget ?? const SizedBox.shrink()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
