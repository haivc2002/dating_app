import 'dart:ui';

import 'package:dating/common/scale_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomSheetCustom {
  final Widget? child;
  final Color? backgroundColor;
  const BottomSheetCustom({
    Key? key,
    this.child,
    this.backgroundColor,
  });

  static void showCustomBottomSheet(BuildContext context, Widget child) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.w),
              topLeft: Radius.circular(20.w),
            ),
            child: Stack(
              children: [
                SizedBox(
                  height: heightScreen(context)*0.9,
                  child: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaY: 30, sigmaX: 30),
                      child: Container(),
                    ),
                  ),
                ),
                SizedBox(
                    height: heightScreen(context)*0.9,
                    width: widthScreen(context),
                    child: Column(
                      children: [
                        Container(
                          height: 5.h,
                          width: 50.w,
                          margin: EdgeInsets.symmetric(vertical: 7.h),
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(100)
                          ),
                        ),
                        child
                      ],
                    )
                )
              ],
            ),
          );
        }
    );
  }
}



