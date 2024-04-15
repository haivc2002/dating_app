import 'package:dating/common/scale_screen.dart';
import 'package:dating/theme/theme_color.dart';
import 'package:dating/theme/theme_image.dart';
import 'package:dating/ui/tool_widget_custom/button_widget_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../tool_widget_custom/event_scale_screen.dart';


class LoginScreen extends StatefulWidget {
  static const routeName = '/loginScreen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {
  late final AnimationService animationService;
  bool shrink = true;


  @override
  void initState() {
    super.initState();
    animationService = AnimationService(this);
  }

  @override
  void dispose() {
    animationService.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.backgroundScaffold,
      resizeToAvoidBottomInset: false,
      body: EventScaleScreen(
        shrink: shrink,
        animationService: animationService,
        child : ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              Center(
                child: Container(
                  height: heightScreen(context),
                  width: widthScreen(context),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(ThemeImage.backgroundLogin),
                          fit: BoxFit.cover
                      )
                  ),
                  child: Container(
                    height: heightScreen(context),
                    width: widthScreen(context),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [ThemeColor.blackColor.withOpacity(0.4), ThemeColor.blackColor],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter
                        )
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [

                    const Spacer(),
                    ButtonWidgetCustom(
                      styleText: TextStyle(
                          color: ThemeColor.blackColor.withOpacity(0.6),
                          fontWeight: FontWeight.bold
                      ),
                      color: ThemeColor.whiteColor,
                      radius: 100,
                      textButton: 'I already have an account',
                      height: 40.h,
                      onTap: () {
                        TestHelper.printSample(
                          context,
                          animationService,
                          (value) {
                            setState(() {
                              shrink = value;
                            });
                          },
                          Container()
                        );
                      },
                    ),
                    SizedBox(height: 20.h),
                    ButtonWidgetCustom(
                      styleText: const TextStyle(
                          color: ThemeColor.whiteColor,
                          fontWeight: FontWeight.bold
                      ),
                      color: ThemeColor.pinkColor,
                      radius: 100,
                      textButton: 'Do not have an account?',
                      height: 40.h,
                      onTap: () {},
                    ),
                    SizedBox(height: 130.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }

}
