import 'package:dating/bloc/bloc_home/home_bloc.dart';
import 'package:dating/model/model_list_nomination.dart';
import 'package:dating/service/service_list_nomination.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:rive/rive.dart';

import '../../bloc/bloc_auth/register_bloc.dart';
import '../../common/global.dart';
import '../../model/location_model/location_current_model.dart';
import '../../model/model_info_user.dart';
import '../../service/location/api_location_current.dart';
import '../../service/service_info_user.dart';
import '../common/scale_screen.dart';
import '../common/textstyles.dart';
import '../theme/theme_color.dart';
import '../theme/theme_rive.dart';
import '../tool_widget_custom/button_widget_custom.dart';

class HomeController {
  BuildContext context;
  HomeController(this.context);

  bool isSwipingTutorial = Global.getBool('swipingTutorial', def: true);
  ServiceListNomination service = ServiceListNomination();
  ApiLocationCurrent apiLocation = ApiLocationCurrent();
  ServiceInfoUser serviceInfoUser = ServiceInfoUser();

  void getData() async {
    onLoad();

    try {
      await getLocation();
    } catch (e) {
      onError('Failed to load location data');
      return;
    }

    try {
      await getInfo();
    } catch (e) {
      onError('Failed to load user info');
      return;
    }

    try {
      await getListNomination();
    } catch (e) {
      onError('Failed to load nomination list');
    }
  }

  Future<void> getListNomination() async {
    try {
      ModelListNomination response = await service.listNomination(
        context,
        idUser: Global.getInt('idUser'),
        gender: 'female',
        radius: 100,
      );
      if (response.result == 'Success') {
        onSuccess(listNomination: response);
      } else {
        throw Exception('Failed to load nominations');
      }
    } catch (e) {
      throw Exception('Failed to load nominations');
    }
  }

  Future<void> getLocation() async {
    try {
      Position? position = await apiLocation.getCurrentPosition(context, LocationAccuracy.high);
      if (context.mounted) {
        context.read<RegisterBloc>().add(RegisterEvent(lat: position?.latitude, lon: position?.longitude));
      }
      if (position != null) {
        LocationCurrentModel response = await apiLocation.locationCurrent(position.latitude, position.longitude);
        if (response.results!.isNotEmpty && context.mounted) {
          List<Results> dataCity = response.results ?? [];
          onSuccess(dataCity: dataCity);
        } else {
          throw Exception('Failed to load location data');
        }
      } else {
        throw Exception('Failed to get position');
      }
    } catch (e) {
      throw Exception('Failed to load location data');
    }
  }

  Future<void> getInfo() async {
    try {
      ModelInfoUser infoModel = await serviceInfoUser.info(Global.getInt('idUser'), context);
      if (infoModel.result == 'Success') {
        onSuccess(info: infoModel);
      } else {
        throw Exception('Failed to load user info');
      }
    } catch (e) {
      throw Exception('Failed to load user info');
    }
  }

  void onSuccess({ModelListNomination? listNomination, List<Results>? dataCity, ModelInfoUser? info}) {
    context.read<HomeBloc>().add(SuccessApiHomeEvent(
      listNomination: listNomination,
      location: dataCity,
      info: info,
    ));
  }

  void onLoad() {
    context.read<HomeBloc>().add(LoadApiHomeEvent());
  }

  void onError(String message) {
    context.read<HomeBloc>().add(ErrorApiHomeEvent(message));
  }

  void backImage(PageController pageController) {
    pageController.previousPage(
      duration: const Duration(milliseconds: 200),
      curve: Curves.fastEaseInToSlowEaseOut
    );
  }

  void nextImage(PageController pageController) {
    pageController.nextPage(
      duration: const Duration(milliseconds: 200),
      curve: Curves.fastEaseInToSlowEaseOut
    );
  }

  String calculateDistance(SuccessApiHomeState state, int itemIndex) {
    double latYou = state.info?.info?.lat ?? 0;
    double lonYou = state.info?.info?.lon ?? 0;
    double latObject = state.listNomination?.nominations?[itemIndex].info?.lat ?? 0;
    double lonObject = state.listNomination?.nominations?[itemIndex].info?.lon ?? 0;
    if (latYou == 0 || lonYou == 0 || latObject == 0 || lonObject == 0) {
      return 'Unknown distance';
    }
    double distanceInMeters = Geolocator.distanceBetween(latYou, lonYou, latObject, lonObject);
    double distanceInKilometers = distanceInMeters / 1000;

    return '${distanceInKilometers.toStringAsFixed(2)}km';
  }

  void popupSwipe() async {
    await Future.delayed(const Duration(seconds: 5));
    if(context.mounted && isSwipingTutorial) {
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