import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rive/rive.dart';

import '../../common/global.dart';
import '../../common/scale_screen.dart';
import '../../common/textstyles.dart';
import '../../theme/theme_color.dart';
import '../../tool_widget_custom/button_widget_custom.dart';

class HomeController {
  BuildContext context;
  HomeController(this.context);

  void popupTutorial() {
    showCupertinoDialog(
      context: context,
      builder: (_) {
        return Container(
            color: ThemeColor.blackColor.withOpacity(0.7),
            child: Column(
              children: [
                const Spacer(),
                Center(
                  child: SizedBox(
                    width: widthScreen(context)*0.7,
                    height: heightScreen(context)*0.7,
                    child: const RiveAnimation.asset(
                      'assets/rive/swiping_tutorial.riv',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                ButtonWidgetCustom(
                  textButton: 'Skip',
                  color: ThemeColor.pinkColor,
                  radius: 100.w,
                  symmetric: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.w),
                  padding: EdgeInsets.symmetric(vertical: 15.w),
                  styleText: TextStyles.defaultStyle.bold.whiteText,
                  onTap: () {
                    Navigator.pop(context);
                    Global.setBool('swipingTutorial', false);
                  },
                )
              ],
            )
        );
      },
    );
  }
}