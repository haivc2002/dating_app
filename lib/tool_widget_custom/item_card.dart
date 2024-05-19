import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/theme_color.dart';

class ItemCard extends StatelessWidget {
  final Color? colorCard, titleColor;
  final String? titleCard;
  final double? fontSize, paddingBottom;
  final Widget? iconTitle;
  final List<Widget>? listWidget;
  const ItemCard({
    Key? key,
    this.colorCard,
    this.titleCard,
    this.fontSize,
    this.titleColor,
    this.iconTitle,
    this.paddingBottom,
    this.listWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, paddingBottom ?? 20.w),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.w),
        child: Material(
          color: colorCard ?? ThemeColor.fadeScaffold,
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              children: [
                Row(
                  children: [
                    iconTitle ?? const SizedBox.shrink(),
                    iconTitle != null ? SizedBox(width: 20.w) : const SizedBox.shrink(),
                    Text(titleCard ?? '', style: TextStyle(
                      fontSize: fontSize ?? 13.sp,
                      fontWeight: FontWeight.bold,
                      color: titleColor ?? ThemeColor.whiteColor
                    ))
                  ],
                ),
                if (listWidget != null) ...listWidget! else const SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
