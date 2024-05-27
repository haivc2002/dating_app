import 'package:dating/common/scale_screen.dart';
import 'package:dating/theme/theme_color.dart';
import 'package:dating/ui/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../tool_widget_custom/button_widget_custom.dart';

class SliderScreen extends StatefulWidget {
  const SliderScreen({Key? key}) : super(key: key);

  @override
  State<SliderScreen> createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {

  int scaledIndex = 0;
  int dynamicBottomIndex = 0;
  double paddingRight = -30;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.4), Colors.black],
                    end: Alignment.bottomCenter,
                    begin: Alignment.topCenter)),
          ),
          listItem(paddingRight+180, 1, Colors.yellow),
          listItem(paddingRight+90, 2, Colors.black),
          listItem(paddingRight, 3, Colors.red),
          Positioned(
              bottom: 30.h,
              child: SizedBox(
                width: widthScreen(context),
                child: Center(
                  child: ButtonWidgetCustom(
                    symetric: EdgeInsets.symmetric(horizontal: 20.w),
                    radius: 100,
                    height: 50,
                    textButton: 'Next',
                    styleText: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500),
                    color: ThemeColor.whiteColor.withOpacity(0.5),
                    onTap: () {
                      setState(() {
                        scaledIndex++;
                        dynamicBottomIndex++;
                        paddingRight = paddingRight + 90;
                        if (scaledIndex == 4) {
                          Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName, (route) => false);
                        }
                      });
                    },
                  ),
                ),
              )
          )
        ],
      ),
    );
  }

  Widget listItem(double padding, int index, Color color) {
    double scale = index == scaledIndex ? 1.0 : 0.18;
    double scaleHeight = index == scaledIndex ? 1.0 : 0.1;
    double dynamicBottom = index == dynamicBottomIndex ? 0 : 180.h;
    double dynamicRight = index == dynamicBottomIndex ? 0 : padding;
    return AnimatedPositioned(
        duration: const Duration(milliseconds: 300),
        bottom: dynamicBottom,
        right: dynamicRight,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.w),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: heightScreen(context)*scaleHeight,
            width: widthScreen(context)*scale,
            color: color,
            curve: Curves.easeIn,
          ),
        )
    );
  }
}
