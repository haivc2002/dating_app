import 'package:dating/common/scale_screen.dart';
import 'package:dating/theme/theme_color.dart';
import 'package:dating/theme/theme_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../tool_widget_custom/bottom_sheet_custom.dart';
import '../../../tool_widget_custom/button_widget_custom.dart';
import '../../../tool_widget_custom/input_custom.dart';
import '../all_tap_bottom/all_tap_bottom_screen.dart';



class LoginScreen extends StatefulWidget {
  static const routeName = '/loginScreen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  BottomSheetCustom bottomSheet = const BottomSheetCustom();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.themeDarkSystem,
      resizeToAvoidBottomInset: false,
      body: Stack(
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
                    BottomSheetCustom.showCustomBottomSheet(context,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(height: 100.h),
                              Row(
                                children: [
                                  Text('Login',
                                    style: TextStyle(
                                        color: ThemeColor.whiteColor,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 30.sp
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(child: Container(
                                    height: 1.h,
                                    color: ThemeColor.whiteColor.withOpacity(0.5),
                                  ))
                                ],
                              ),
                              SizedBox(height: 30.h),
                              InputCustom(
                                controller: emailController,
                                colorInput: ThemeColor.blackColor.withOpacity(0.3),
                                labelText: 'Email',
                                keyboardType: TextInputType.emailAddress,
                              ),
                              SizedBox(height: 20.h),
                              InputCustom(
                                controller: passController,
                                hidePass: true,
                                colorInput: ThemeColor.blackColor.withOpacity(0.3),
                                labelText: 'passWord',
                                keyboardType: TextInputType.visiblePassword,
                              ),
                              SizedBox(height: 20.h),
                              ButtonWidgetCustom(
                                textButton: 'Login',
                                height: 40.h,
                                radius: 10.w,
                                color: ThemeColor.pinkColor.withOpacity(0.6),
                                styleText: TextStyle(
                                  color: ThemeColor.whiteColor,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.pushNamedAndRemoveUntil(context, AllTapBottomScreen.routeName, (route) => false);
                                  // Navigator.pushNamed(context, AllTapDrawerScreen.routeName);
                                },
                              )
                            ],
                          ),
                        ),
                      )
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
      )
    );
  }

}
