import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/theme_color.dart';

class ButtonWidgetCustom extends StatelessWidget {
  final void Function()? onTap;
  final Color? color;
  final String textButton;
  final double? height, width, radius;
  final EdgeInsetsGeometry? symmetric, padding;
  final TextStyle? styleText;

  const ButtonWidgetCustom({
    Key? key,
    this.onTap,
    this.color,
    required this.textButton,
    this.radius,
    this.height,
    this.width,
    this.symmetric,
    this.styleText,
    this.padding
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: symmetric,
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 0)
      ),
      child: Material(
        color: color ?? ThemeColor.whiteColor,
        borderRadius: BorderRadius.circular(radius ?? 0),
        child: InkWell(
          borderRadius: BorderRadius.circular(radius ?? 0),
          onTap: onTap,
          child: Center(
            child: Padding(
              padding: padding ?? EdgeInsets.symmetric(vertical: 10.w),
              child: Text(textButton, style: styleText),
            ),
          ),
        ),
      ),
    );
  }
}
