import 'dart:ui';

import 'package:dating/common/scale_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomSheetCustom {
  final Widget? child;
  final Color? backgroundColor;
  final double? height;
  const BottomSheetCustom({
    Key? key,
    this.child,
    this.backgroundColor,
    this.height,
  });

  static void showCustomBottomSheet(BuildContext context, Widget child, {double? height,double? circular, Color? backgroundColor, Function? whenComplete, double? blur}) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Stack(
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaY: 3, sigmaX: 3),
                child: Container(),
              ),
              Column(
                children: [
                  Expanded(child: GestureDetector(
                    onTap: ()=> Navigator.pop(context),
                    child: Container(color: Colors.transparent),
                  )),
                  IntrinsicHeight(
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(circular ?? 20.w)),
                      child: Stack(
                        children: [
                          SizedBox(
                            height: height/* ?? heightScreen(context)*0.9*/,
                            child: ClipRect(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaY: blur ?? 30, sigmaX: blur ?? 30),
                                child: Container(),
                              ),
                            ),
                          ),
                          Container(
                            color: backgroundColor,
                            height: height/* ?? heightScreen(context)*0.9*/,
                            width: widthScreen(context),
                            child: Column(
                              children: [
                                Container(
                                  height: 5.h,
                                  width: 50.w,
                                  margin: EdgeInsets.symmetric(vertical: 10.h),
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(100)
                                  ),
                                ),
                                Expanded(child: child),
                                // child
                                SizedBox(height: 20.w)
                              ],
                            )
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        }
    ).then((_)=> whenComplete);
  }
}



