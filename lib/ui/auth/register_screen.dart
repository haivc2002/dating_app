import 'dart:ui';

import 'package:dating/common/scale_screen.dart';
import 'package:dating/common/textstyles.dart';
import 'package:dating/controller/auth_controller/register_controller.dart';
import 'package:dating/theme/theme_color.dart';
import 'package:dating/tool_widget_custom/input_custom.dart';
import 'package:dating/ui/auth/register_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rive/rive.dart';

import '../../bloc/bloc_auth/register_bloc.dart';
import '../../tool_widget_custom/btn_next_back.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'registerScreen';
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  late RegisterController controller;
  @override
  void initState() {
    super.initState();
    controller = RegisterController(context);
    controller.preload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _background(),
          _stackWellCome(),
        ],
      )
    );
  }

  Widget _stackWellCome() {
    return GestureDetector(
      onTap: ()=>FocusScope.of(context).unfocus(),
      onVerticalDragDown: (detail)=>FocusScope.of(context).unfocus(),
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Text('WellCome!', style: TextStyles.defaultStyle.bold.setTextSize(30.sp).whiteText),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.w)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaY: 30, sigmaX: 30),
              child: Container(
                width: widthScreen(context),
                decoration: BoxDecoration(
                    color: ThemeColor.themeLightSystem.withOpacity(0.5),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20.w)),
                    border: Border(top: BorderSide(width: 2.w, color: ThemeColor.whiteColor.withOpacity(0.4)))
                ),
                padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Register', style: TextStyles.defaultStyle.bold.setTextSize(27.sp)),
                    Text('Let\'s start with your account', style: TextStyles.defaultStyle.setColor(ThemeColor.blackColor.withOpacity(0.5)),),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InputCustom(
                          controller: controller.emailController,
                          labelText: 'Email',
                          colorInput: ThemeColor.blackColor.withOpacity(0.4),
                          labelColor: ThemeColor.whiteColor.withOpacity(0.5),
                          colorText: ThemeColor.whiteColor,
                        ),
                        SizedBox(height: 10.w),
                        InputCustom(
                          controller: controller.passwordController,
                          labelText: 'Password',
                          colorInput: ThemeColor.blackColor.withOpacity(0.4),
                          labelColor: ThemeColor.whiteColor.withOpacity(0.5),
                          colorText: ThemeColor.whiteColor,
                        ),
                        SizedBox(height: 10.w),
                        InputCustom(
                          controller: controller.confirmPasswordController,
                          labelText: 'ConfirmPassword',
                          colorInput: ThemeColor.blackColor.withOpacity(0.4),
                          labelColor: ThemeColor.whiteColor.withOpacity(0.5),
                          colorText: ThemeColor.whiteColor,
                        ),
                        SizedBox(height: 10.w),
                        Row(
                          children: [
                            Expanded(child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 20.w, 0),
                              child: Divider(color: ThemeColor.blackColor.withOpacity(0.2)),
                            )),
                            Text('Or', style: TextStyles.defaultStyle),
                            Expanded(child: Padding(
                              padding: EdgeInsets.fromLTRB(20.w, 0, 0, 0),
                              child: Divider(color: ThemeColor.blackColor.withOpacity(0.2)),
                            )),
                          ],
                        ),
                        _authOther(
                            title: 'FaceBook',
                            color: ThemeColor.blueColor,
                            icon: Icons.facebook
                        ),
                        _authOther(
                            title: 'Google',
                            color: ThemeColor.redColor,
                            icon: FontAwesomeIcons.google
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.w),
                      child: BtnNextBack(
                        title: 'NEXT',
                        onTap: ()=> controller.register(),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _background() {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return Container(
          color: ThemeColor.pinkColor,
          child: state.fileRive == null
            ? const SizedBox.shrink()
            : RiveAnimation.direct(state.fileRive!)
        );
      }
    );
  }

  Widget _authOther({required IconData icon, required String title, required Color color}) {
    return Center(
      child: Container(
        width: widthScreen(context)/2.5,
        height: 30.w,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5.w)
        ),
        margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: ThemeColor.whiteColor),
            SizedBox(width: 10.w),
            Text(title, style: TextStyles.defaultStyle.bold.whiteText)
          ],
        ),
      ),
    );
  }
}
