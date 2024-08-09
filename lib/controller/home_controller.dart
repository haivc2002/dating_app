import 'package:dating/bloc/bloc_home/home_bloc.dart';
import 'package:dating/model/model_list_nomination.dart';
import 'package:dating/model/model_req_match.dart';
import 'package:dating/model/model_update_location.dart';
import 'package:dating/service/service_list_nomination.dart';
import 'package:dating/service/service_match.dart';
import 'package:dating/service/service_update.dart';
import 'package:dating/tool_widget_custom/popup_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rive/rive.dart';

import '../../common/global.dart';
import '../../model/location_model/location_current_model.dart';
import '../../model/model_info_user.dart';
import '../../service/location/api_location_current.dart';
import '../../service/service_info_user.dart';
import '../common/scale_screen.dart';
import '../common/textstyles.dart';
import '../model/model_res_update_location.dart';
import '../model/model_response_match.dart';
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
  ServiceUpdate serviceUpdate = ServiceUpdate();
  ServiceMatch addMatch = ServiceMatch();

  Future<void> getData(int rangeValue) async {
    onLoad(true);
    try {
      await getLocation();
    } catch (e) {
      onError('Failed to load location data');
      return;
    }
    try {
      await getListNomination(rangeValue);
    } catch (e) {
      onError('Failed to load nomination list');
    }
  }

  Future<void> getLocation() async {
    try {
      Position? position = await apiLocation.getCurrentPosition(context, LocationAccuracy.high);
      if (position == null) {
        onLoad(false);
        throw Exception('Failed to get position');
      }

      LocationCurrentModel response = await apiLocation.locationCurrent(position.latitude, position.longitude);
      if (response.results?.isEmpty ?? true) {
        onLoad(false);
        throw Exception('Failed to load location data');
      }
      List<Results> dataCity = response.results ?? [];
      onSuccess(dataCity: dataCity);
      await setLocation(position.latitude, position.longitude);
    } catch (e) {
      onLoad(false);
      throw Exception('Failed to load location data');
    }
  }

  Future<void> setLocation(double latValue, double lonValue) async {
    try {
      ModelUpdateLocation requestLocation = ModelUpdateLocation(
        idUser: Global.getInt("idUser"),
        lat: latValue,
        lon: lonValue,
      );
      ModelResUpdateLocation response = await serviceUpdate.updateLocation(requestLocation);

      if (response.result != 'Success') {
        onLoad(false);
        throw Exception('Failed to update location');
      }
      await getInfo();
    } catch (e) {
      onLoad(false);
      throw Exception('Failed to update location');
    }
  }

  Future<void> getInfo() async {
    try {
      ModelInfoUser infoModel = await serviceInfoUser.info(Global.getInt('idUser'), context);

      if (infoModel.result != 'Success') {
        onLoad(false);
        throw Exception('Failed to load user info');
      }
      onSuccess(info: infoModel);
    } catch (e) {
      onLoad(false);
      throw Exception('Failed to load user info');
    }
  }

  Future<void> getListNomination(int rangeValue) async {
    try {
      ModelListNomination response = await service.listNomination(
        context,
        idUser: Global.getInt('idUser'),
        gender: 'female',
        radius: rangeValue,
      );
      if (response.result != 'Success') {
        onLoad(false);
        throw Exception('Failed to load nominations');
      }
      onSuccess(listNomination: response);
    } catch (e) {
      onLoad(false);
      throw Exception('Failed to load nominations');
    }
  }

  void onSuccess({ModelListNomination? listNomination, List<Results>? dataCity, ModelInfoUser? info}) {
    context.read<HomeBloc>().add(HomeEvent(
      listNomination: listNomination,
      location: dataCity,
      info: info,
    ));
    onLoad(false);
  }

  void onLoad(bool isLoading) {
    context.read<HomeBloc>().add(HomeEvent(isLoading: isLoading));
  }

  void onError(String message) {
    onLoad(false);
    context.read<HomeBloc>().add(HomeEvent(message: message));
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

  String calculateDistance({required double latYou,required double lonYou,required double latOj,required double lonOj}) {
    if (latYou == 0 || lonYou == 0 || latOj == 0 || lonOj == 0) {
      return 'Unknown distance';
    }
    double distanceInMeters = Geolocator.distanceBetween(latYou, lonYou, latOj, lonOj);
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

  void match(int keyMatch) async {
    ModelReqMatch requestMatch = ModelReqMatch(
      idUser: Global.getInt('idUser'),
      keyMatch: keyMatch
    );
    ModelResponseMatch response = await addMatch.match(requestMatch);
    if(response.result == 'Success' && context.mounted) {
      context.read<HomeBloc>().add(HomeEvent(match: response));
    } else {
      if(context.mounted) {
        PopupCustom.showPopup(context, 
            content: const Text('The server is busy!'),
            listOnPress: [()=> Navigator.pop(context)],
            listAction: [Text('Ok', style: TextStyles.defaultStyle.bold.setColor(ThemeColor.blueColor))]
        );
      }
    }
  }

}