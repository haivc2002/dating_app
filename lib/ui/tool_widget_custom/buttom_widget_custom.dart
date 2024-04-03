import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/theme_color.dart';

class ButtonWidgetCustom extends StatelessWidget {
  final void Function()? onTap;
  final Color? color;
  final String textButton;
  final double? height, width, radius;
  final EdgeInsetsGeometry? symetric;
  final TextStyle? styleText;

  const ButtonWidgetCustom({
    Key? key,
    this.onTap,
    this.color,
    required this.textButton,
    this.radius,
    this.height,
    this.width,
    this.symetric,
    this.styleText
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: symetric,
      height: height?.h,
      width: width?.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 0)
      ),
      child: Material(
        color: color ?? ThemeColor.whiteColor,
        borderRadius: BorderRadius.circular(radius ?? 0),
        child: InkWell(
          borderRadius: BorderRadius.circular(radius ?? 0),
          onTap: onTap,
          child: Center(child: Text(textButton, style: styleText),),
        ),
      ),
    );
  }
}
