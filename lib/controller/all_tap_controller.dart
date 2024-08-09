import 'package:dating/bloc/bloc_all_tap/api_all_tap_bloc.dart';
import 'package:dating/bloc/bloc_auth/register_bloc.dart';
import 'package:dating/controller/home_controller.dart';
import 'package:dating/model/model_info_user.dart';
import 'package:dating/service/location/api_location_current.dart';
import 'package:dating/service/service_info_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../bloc/bloc_all_tap/all_tap_bloc.dart';
import '../common/global.dart';
import '../model/location_model/location_current_model.dart';
import '../ui/auth/login_screen.dart';

class AllTapController {
  BuildContext context;
  AllTapController(this.context);

  bool isSwipingTutorial = Global.getBool('swipingTutorial', def: true);
  PageController pageController= PageController();
  ApiLocationCurrent apiLocation = ApiLocationCurrent();
  int selectedIndex = 0;
  ServiceInfoUser serviceInfoUser = ServiceInfoUser();

  void onItemTapped(int index) {
    selectedIndex = index;
    context.read<AllTapBloc>().add(AllTapEvent(selectedIndex: selectedIndex));
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
  }

  void openDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  void getData() async {
    onLoad();
    Position? position = await apiLocation.getCurrentPosition(context, LocationAccuracy.high);
    if(context.mounted) {
      context.read<RegisterBloc>().add(RegisterEvent(lat: position?.latitude, lon: position?.longitude));
    }
    if (position != null) {
      LocationCurrentModel response = await apiLocation.locationCurrent(position.latitude, position.longitude);
      if (response.results!.isNotEmpty && context.mounted) {
        List<Results> dataCity = response.results ?? [];
        onSuccess(response: dataCity);
        ModelInfoUser infoModel = await serviceInfoUser.info(Global.getInt('idUser'), context);
        if(infoModel.result == 'Success') {
          onSuccess(info: infoModel);
        } else {
          onError();
        }
      } else {
        onError();
      }
    } else {
      onError();
    }
  }

  void onLoad() {
    context.read<ApiAllTapBloc>().add(LoadApiAllTapEvent());
  }

  void onSuccess({List<Results>? response, ModelInfoUser? info}) {
    context.read<ApiAllTapBloc>().add(SuccessApiAllTapEvent(response: response, info: info));
  }

  void onError() {
    print('Error!!!!!!');
  }

  void onSignOut() {
    Global.setInt('idUser', -1);
    Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName, (route) => false);
  }
}