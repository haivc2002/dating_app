import 'package:dating/common/textstyles.dart';
import 'package:dating/theme/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListTileCustom extends StatelessWidget {
  final String? title, subtitle;
  final Color? color;
  final Function()? onTap;
  final IconData? iconLeading, iconTrailing;
  const ListTileCustom({
    Key? key,
    this.title,
    this.iconLeading,
    this.iconTrailing,
    this.color,
    this.subtitle,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10.w),
      color: color ?? ThemeColor.whiteColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(10.w),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.w),
          child: ListTile(
            title: Text(title??'', style: TextStyles.defaultStyle.bold.setTextSize(17.w).setColor(ThemeColor.blackColor)),
            subtitle: Text(subtitle??'', style: TextStyles.defaultStyle),
            leading: Icon(iconLeading, color: ThemeColor.blackColor),
            trailing: Icon(iconTrailing, color: ThemeColor.blackColor),
          ),
        ),
      ),
    );
  }
}
