import 'package:dating/bloc/bloc_home/home_bloc.dart';
import 'package:dating/common/textstyles.dart';
import 'package:dating/model/model_list_nomination.dart';
import 'package:dating/service/service_list_nomination.dart';
import 'package:dating/theme/theme_color.dart';
import 'package:dating/tool_widget_custom/popup_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/global.dart';

class HomeController {
  BuildContext context;
  HomeController(this.context);

  bool isSwipingTutorial = Global.getBool('swipingTutorial', def: true);
  ServiceListNomination service = ServiceListNomination();

  void getListNomination() async {
    onLoad();
    ModelListNomination response = await service.listNomination(
      context,
      idUser: Global.getInt('idUser'),
      gender: 'female',
      radius: 1
    );
    if(response.result == 'Success') {
      onSuccess(response);
    } else {
      onError();
    }
  }

  void onSuccess(ModelListNomination response) {
    context.read<HomeBloc>().add(SuccessApiHomeEvent(response));
  }

  void onLoad() {
    context.read<HomeBloc>().add(LoadApiHomeEvent());
  }

  void onError() {
    PopupCustom.showPopup(
      context,
      listOnPress: [()=> Navigator.pop(context)],
      listAction: [Text('Ok', style: TextStyles.defaultStyle.bold.setColor(ThemeColor.blueColor))]
    );
  }
}