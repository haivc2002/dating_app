import 'dart:ui';

import 'package:dating/common/scale_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../theme/theme_notifier.dart';

class AppBarCustom extends StatelessWidget {
  final String? title;
  final Widget? leadingIcon;
  final TextStyle? textStyle;
  final ScrollPhysics? scrollPhysics;
  final List<Widget>? bodyListWidget;
  final TextAlign? textAlign;
  final Widget? trailing;
  final bool? showLeading;
  const AppBarCustom({
    Key? key,
    this.title,
    this.leadingIcon,
    this.textStyle,
    this.bodyListWidget,
    this.scrollPhysics,
    this.textAlign,
    this.trailing,
    this.showLeading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Stack(
      children: [
        SingleChildScrollView(
          physics: scrollPhysics,
          child: Column(
            children: [
              SizedBox(
                height: 100.w,
                width: widthScreen(context),
              ),
              if (bodyListWidget != null) ...bodyListWidget!,
              SizedBox(height: 100.w)
            ],
          ),
        ),
        SizedBox(
          height: 100.w,
          width: widthScreen(context),
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(),
            ),
          ),
        ),
        Container(
          height: 100.w,
          width: widthScreen(context),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [themeNotifier.systemTheme, themeNotifier.systemTheme.withOpacity(0.5)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )
        ),
          child: Column(
            children: [
              SizedBox(height: 50.w),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    showLeading ?? true == true ? Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 20.w, 0),
                      child: SizedBox(
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
                                          color: themeNotifier.systemText
                                      ),
                                    ),
                                  ),
                                )
                                    : leadingIcon ?? const SizedBox()
                            ),
                          ),
                        ),
                      ),
                    ) : const SizedBox.shrink(),
                    Expanded(child: Text(title ?? '', style: textStyle, textAlign: textAlign)),
                    SizedBox(width: 20.w),
                    trailing != null ? SizedBox(
                      height: 30.w,
                      width: 30.w,
                      child: Container(
                        decoration: BoxDecoration(
                            color: themeNotifier.highlight.withOpacity(0.2),
                            shape: BoxShape.circle
                        ),
                        child: Center(
                          child: trailing ?? const SizedBox(),
                        ),
                      ),
                    ) : SizedBox(width: 30.w)
                  ],
                ),
              )
            ],
          )
        )
      ],
    );
  }
}