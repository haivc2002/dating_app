import 'package:dating/bloc/bloc_all_tap/api_all_tap_bloc.dart';
import 'package:dating/bloc/bloc_auth/register_bloc.dart';
import 'package:dating/model/model_info_user.dart';
import 'package:dating/service/location/api_location_current.dart';
import 'package:dating/service/service_info_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rive/rive.dart';

import '../../bloc/bloc_all_tap/all_tap_bloc.dart';
import '../../common/global.dart';
import '../../common/scale_screen.dart';
import '../../common/textstyles.dart';
import '../../model/location_model/location_current_model.dart';
import '../../theme/theme_color.dart';
import '../../theme/theme_rive.dart';
import '../../tool_widget_custom/button_widget_custom.dart';

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
    context.read<AllTapBloc>().add(AllTapEvent(selectedIndex));
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
      if(isSwipingTutorial) {
        popupSwipe();
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

  void popupSwipe() async {
    await Future.delayed(const Duration(seconds: 2));
    if(context.mounted) {
      showCupertinoDialog(
        context: context,
        builder: (_) {
          return Material(
            color: ThemeColor.blackColor.withOpacity(0.8),
            child: Column(
              children: [
                const Spacer(),
                Center(
                  child: SizedBox(
                    width: widthScreen(context)*0.7,
                    height: heightScreen(context)*0.7,
                    child: const RiveAnimation.asset(
                      ThemeRive.swipeTutorial,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text('Swipe right, you say you like them', style: TextStyles.defaultStyle.whiteText),
                Text('Swipe left, Nope', style: TextStyles.defaultStyle.whiteText),
                ButtonWidgetCustom(
                  textButton: 'Skip',
                  color: ThemeColor.pinkColor,
                  radius: 100.w,
                  symmetric: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.w),
                  padding: EdgeInsets.symmetric(vertical: 15.w),
                  styleText: TextStyles.defaultStyle.bold.whiteText,
                  onTap: () {
                    Navigator.pop(context);
                    popupDetail();
                  },
                )
              ],
            ),
          );
        },
      );
    }
  }

  void popupDetail() async {
    await Future.delayed(const Duration(seconds: 2));
    if(context.mounted) {
      showCupertinoDialog(
        context: context,
        builder: (_) {
          return Material(
            color: ThemeColor.blackColor.withOpacity(0.8),
            child: Column(
              children: [
                const Spacer(),
                Center(
                  child: SizedBox(
                    width: widthScreen(context)*0.7,
                    height: heightScreen(context)*0.7,
                    child: const RiveAnimation.asset(
                      ThemeRive.pressHoldTutorial,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text('Touch and hold to view that user\'s details', style: TextStyles.defaultStyle.whiteText),
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
            ),
          );
        },
      );
    }
  }

}