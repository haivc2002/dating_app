import 'package:dating/argument_model/argument_register_info.dart';
import 'package:dating/common/global.dart';
import 'package:dating/common/textstyles.dart';
import 'package:dating/model/model_info_user.dart';
import 'package:dating/model/model_request_auth.dart';
import 'package:dating/theme/theme_icon.dart';
import 'package:dating/tool_widget_custom/popup_custom.dart';
import 'package:dating/ui/auth/register_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../service/service_login.dart';
import '../theme/theme_color.dart';
import '../tool_widget_custom/bottom_sheet_custom.dart';
import '../tool_widget_custom/button_widget_custom.dart';
import '../tool_widget_custom/input_custom.dart';
import '../ui/all_tap_bottom/all_tap_bottom_screen.dart';

class LoginController {

  BuildContext context;
  LoginController(this.context);

  ServiceLogin serviceLogin = ServiceLogin();
  ModelRequestAuth req = ModelRequestAuth();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  void popupLogin() {
    BottomSheetCustom.showCustomBottomSheet(context,
      backgroundColor: ThemeColor.whiteIos.withOpacity(0.3),
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
                  Expanded(child: Divider(
                    color: ThemeColor.whiteColor.withOpacity(0.5),
                  ))
                ],
              ),
              SizedBox(height: 30.h),
              InputCustom(
                controller: emailController,
                colorInput: ThemeColor.blackColor.withOpacity(0.3),
                labelText: 'Email',
                colorText: ThemeColor.whiteColor,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20.h),
              InputCustom(
                controller: passController,
                hidePass: true,
                colorInput: ThemeColor.blackColor.withOpacity(0.3),
                labelText: 'passWord',
                colorText: ThemeColor.whiteColor,
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
                onTap: ()=> login(emailController.text, passController.text)
              ),
              SizedBox(height: 20.h),
              SizedBox(
                height: 30.w,
                width: 150.w,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: ThemeColor.whiteColor,
                    borderRadius: BorderRadius.circular(6.w),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 30.w,
                          width: 30.w,
                          child: Image.asset(ThemeIcon.iconGoogle),
                        ),
                        Expanded(child: Center(child: Text('Google', style: TextStyles.defaultStyle.bold))),
                        SizedBox(
                          height: 30.w,
                          width: 30.w,
                        ),
                      ],
                    ),
                  )
                ),
              )
            ],
          ),
        ),
      )
    );
  }

  void login(String email, String password) async {
    initModelRequestLogin(email, password);
    ModelInfoUser response = await serviceLogin.login(req);
    if(response.result == 'Success') {
      onSuccess(response);
    } else {
      onError(response);
    }
  }

  void initModelRequestLogin(String email, String password) {
    req = ModelRequestAuth(
      email : email,
      password: password
    );
  }

  void onSuccess(ModelInfoUser response) async {
    Navigator.pop(context);
    Global.setInt('idUser', response.idUser!);
    await Future.delayed(const Duration(milliseconds: 250));
    if(context.mounted) {
      if(response.info?.name != null) {
        Navigator.pushNamedAndRemoveUntil(context, AllTapBottomScreen.routeName, (route) => false);
      } else {
        Navigator.pushNamed(
          context,
          RegisterInfoScreen.routeName,
          arguments: ArgumentRegisterInfo(email: emailController.text, password: passController.text)
        );
      }

    }
  }

  void onError(ModelInfoUser response) {
    PopupCustom.showPopup(context,
      content: Text('${response.message}'),
      listOnPress: [()=> Navigator.pop(context)],
      listAction: [Text('Ok', style: TextStyles.defaultStyle.bold.setColor(ThemeColor.blueColor))]
    );
  }

  _loginWithGoogle() async {

  }

}