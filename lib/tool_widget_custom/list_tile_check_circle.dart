import 'package:auto_size_text/auto_size_text.dart';
import 'package:dating/common/textstyles.dart';
import 'package:dating/theme/theme_color.dart';
import 'package:dating/theme/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ListTileCheckCircle extends StatelessWidget {
  final Color? color, titleColor, iconColor;
  final String? title;
  final IconData? iconData;
  final Function()? onTap;
  const ListTileCheckCircle({
    Key? key,
    this.color,
    this.titleColor,
    this.iconColor,
    this.title,
    this.iconData,
    this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Material(
      borderRadius: BorderRadius.circular(100.w),
      color: color ?? themeNotifier.systemTheme,
      child: InkWell(
        splashColor: ThemeColor.whiteColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(100.w),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
          child: Row(
            children: [
              Expanded(
                child: AutoSizeText(
                  title??'',
                  style: TextStyles.defaultStyle.bold.setColor(titleColor ?? themeNotifier.systemText),
                  maxLines: 1,
                )
              ),
              const Spacer(),
              Icon(iconData, color: iconColor ?? themeNotifier.systemText)
            ],
          ),
        ),
      ),
    );
  }
}
