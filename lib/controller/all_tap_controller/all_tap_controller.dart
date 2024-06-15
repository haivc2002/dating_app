import 'package:dating/bloc/bloc_all_tap/get_location_bloc.dart';
import 'package:dating/service/location/api_location_current.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../bloc/bloc_all_tap/all_tap_bloc.dart';
import '../../model/location_model/location_current_model.dart';
import '../../tool_widget_custom/popup_custom.dart';

class AllTapController {
  BuildContext context;
  int selectedIndex = 0;
  PageController pageController= PageController();
  ApiLocationCurrent apiLocation = ApiLocationCurrent();
  AllTapController(this.context);
  double lat = 0;
  double lot = 0;

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
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    LocationCurrentModel response = await apiLocation.locationCurrent(position.latitude, position.longitude);
    if(response.results!.isNotEmpty) {
      List<Results> dataCity = response.results ?? [];
      onSuccess(dataCity);
    } else {
      onError();
    }
  }

  void onLoad() {
    context.read<GetLocationBloc>().add(LoadGetLocationEvent());
  }

  void onSuccess(List<Results> response) {
    context.read<GetLocationBloc>().add(SuccessGetLocationEvent(response));
  }

  void onError() {
    print('Error!!!!!!');
  }

}