import 'dart:ui';

import 'package:dating/common/scale_screen.dart';
import 'package:dating/theme/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarCustom extends StatelessWidget {
  final String? title;
  final Widget? leadingIcon;
  final TextStyle? textStyle;
  const AppBarCustom({
    Key? key,
    this.title,
    this.leadingIcon,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 100.w,
                width: widthScreen(context),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 100.w,
          width: widthScreen(context),
          child: ClipRect(
            child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                    SizedBox(
                      height: 30.w,
                      width: 30.w,
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Material(
                            color: Colors.transparent,
                            child: (Navigator.canPop(context) && leadingIcon == null)
                              ? InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: EdgeInsets.all(4.w),
                                child: Center(
                                  child: Icon(
                                      Icons.arrow_back_ios_new,
                                      size: 17.sp,
                                      color: ThemeColor.whiteColor
                                  ),
                                ),
                              ),
                            )
                              : leadingIcon ?? const SizedBox()
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20.w),
                    Text(title ?? '', style: textStyle),
                ],
              ),
            ),
          ),
        )
        )
      ],
    );
  }
}
