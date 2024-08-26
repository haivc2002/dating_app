import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../common/extension/gradient.dart';
import '../../common/scale_screen.dart';
import '../../common/textstyles.dart';
import '../../theme/theme_color.dart';
import '../../theme/theme_image.dart';
import '../../theme/theme_notifier.dart';

class StateScreen {
  static Widget wait(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: SizedBox(
          height: heightScreen(context)*0.8,
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.w,
                childAspectRatio: 0.76,
                mainAxisSpacing: 6.w,
              ),
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.w),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.w),
                    child: ColoredBox(
                      color: themeNotifier.systemThemeFade,
                      child: Column(
                        children: [
                          const Spacer(),
                          SizedBox(
                            height: 60.w,
                            width: double.infinity,
                            child: DecoratedBox(
                              decoration: BoxDecoration(gradient: GradientColor.gradientBlackFade),
                              child: Shimmer.fromColors(
                                baseColor: themeNotifier.systemThemeFade,
                                highlightColor: themeNotifier.systemTheme,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(10.w, 0, 30.w, 0),
                                      child: SizedBox(
                                        height: 13.w,
                                        width: double.infinity,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(100.w),
                                          child: const ColoredBox(color: ThemeColor.themeDarkSystem),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 7.w),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(10.w, 0, 70.w, 0),
                                      child: SizedBox(
                                        height: 10.w,
                                        width: double.infinity,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(100.w),
                                          child: const ColoredBox(color: ThemeColor.themeDarkSystem),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }
          )
      ),
    );
  }

  static Widget error(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return SizedBox(
      height: heightScreen(context)*0.6,
      child: SizedBox(
        width: widthScreen(context)*0.7,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(ThemeImage.error),
              SizedBox(height: 20.w),
              Text('Error! Failed to load data!', style: TextStyles.defaultStyle.setColor(themeNotifier.systemText))
            ],
          ),
        ),
      ),
    );
  }
}