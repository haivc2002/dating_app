import 'dart:async';

import 'package:dating/argument_model/argument_register_info.dart';
import 'package:dating/bloc/bloc_auth/register_bloc.dart';
import 'package:dating/model/model_base.dart';
import 'package:dating/service/service_register.dart';
import 'package:dating/theme/theme_rive.dart';
import 'package:dating/ui/auth/register_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';

import '../../bloc/bloc_auth/api_register_bloc.dart';
import '../../common/textstyles.dart';
import '../../model/model_request_auth.dart';
import '../../theme/theme_color.dart';
import '../../tool_widget_custom/popup_custom.dart';

class RegisterController {
  BuildContext context;
  RegisterController(this.context);

  ServiceRegister serviceRegister = ServiceRegister();

  RiveFile? fileRive;
  int remainingTime = 60;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  ModelRequestAuth req = ModelRequestAuth();

  Future<void> preload() async {
    rootBundle.load(ThemeRive.backgroundRegister).then((data) async {
      fileRive = RiveFile.import(data);
      context.read<RegisterBloc>().add(RegisterEvent(fileRive: fileRive));
    });
  }

  void register() async {
    FocusScope.of(context).unfocus();
    await Future.delayed(const Duration(milliseconds: 300));
    initModel();
    if(passwordController.text == confirmPasswordController.text) {
      if(context.mounted) {
        ModelBase response = await serviceRegister.register(req, context);
        if(response.result == "Success") {
          onSuccess(response);
        } else {
          onError('${response.message}');
        }
      }
    } else {
      onError('Confirmation failure!');
    }
  }

  void initModel() {
    req = ModelRequestAuth(
      email: emailController.text,
      password: passwordController.text,
    );
  }

  void onError(String content) {
    PopupCustom.showPopup(context,
        content: Text(content, style: TextStyles.defaultStyle),
        listOnPress: [()=>Navigator.pop(context)],
        listAction: [Text('Ok', style: TextStyles.defaultStyle.setColor(ThemeColor.blueColor).bold)]
    );
  }

  void onSuccess(ModelBase response) {
    context.read<ApiRegisterBloc>().add(SuccessApiRegisterEvent(response: response));
    Navigator.pushReplacementNamed(
      context,
      RegisterInfoScreen.routeName,
      arguments: ArgumentRegisterInfo(password: passwordController.text, email: emailController.text)
    );
  }
}