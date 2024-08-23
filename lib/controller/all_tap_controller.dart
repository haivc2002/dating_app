import 'dart:async';
import 'dart:convert';

import 'package:dating/bloc/bloc_all_tap/api_all_tap_bloc.dart';
import 'package:dating/bloc/bloc_auth/register_bloc.dart';
import 'package:dating/model/model_info_user.dart';
import 'package:dating/service/location/api_location_current.dart';
import 'package:dating/service/service_info_user.dart';
import 'package:dating/ui/home/home_screen.dart';
import 'package:dating/ui/message/message_screen.dart';
import 'package:dating/ui/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:swipable_stack/swipable_stack.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../bloc/bloc_all_tap/all_tap_bloc.dart';
import '../common/global.dart';
import '../model/location_model/location_current_model.dart';
import '../service/url/api.dart';
import '../ui/auth/login_screen.dart';
import '../ui/premium/premium_screen.dart';

class AllTapController {
  BuildContext context;
  AllTapController(this.context);

  bool isSwipingTutorial = Global.getBool('swipingTutorial', def: true);
  ApiLocationCurrent apiLocation = ApiLocationCurrent();
  int selectedIndex = 0;
  ServiceInfoUser serviceInfoUser = ServiceInfoUser();

  WebSocketChannel? channel;
  final String urlConnect = Api.notification;
  Timer? timer;
  int retryCount = 0;
  final int maxRetries = 3;

  int matchCount = 0;
  int messageCount = 0;

  void onItemTapped(int index) {
    selectedIndex = index;
    context.read<AllTapBloc>().add(AllTapEvent(selectedIndex: selectedIndex));
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

  Widget screenChange(AllTapState state, AnimationController animationController, BuildContext context, SwipableStackController swiController) {
    switch (state.selectedIndex) {
      case 0:
        return HomeScreen(openDrawer: openDrawer, buildContext: context, animationController: animationController, swiController: swiController,);
      case 1:
        return const PremiumScreen();
      case 2:
        return const MessageScreen();
      case 3:
        return const ProfileScreen();
      default:
        return HomeScreen(openDrawer: openDrawer, buildContext: context, animationController: animationController, swiController: swiController,);
    }
  }

  void continuous(String idUser) {
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (context.mounted) {
        connect(idUser);
      }
    });
  }

  void connect(String idUser) {
    channel?.sink.close();
    channel = IOWebSocketChannel.connect(Uri.parse(urlConnect));

    channel?.stream.listen(
          (message) {
        if (context.mounted) {
          final data = jsonDecode(message);
          matchCount = data['matchCount'] ?? matchCount;
          messageCount = data['newMessages'] ?? messageCount;

          context.read<AllTapBloc>().add(AllTapEvent(matchCount: matchCount, messageCount: messageCount));
          retryCount = 0;
        }
      },
      onError: (error) {if (context.mounted) handleConnectionError(idUser);},
      onDone: () {if (context.mounted) handleConnectionError(idUser);},
    );
    channel?.sink.add(jsonEncode({'idUser': idUser, "type": "match",}));
  }

  void handleConnectionError(String idUser) {
    retryCount++;
    if (retryCount <= maxRetries) {
      reconnect(idUser);
    } else {
      stopReconnecting();
    }
  }

  void reconnect(String idUser) {
    channel?.sink.close();
    Future.delayed(const Duration(seconds: 5), () {
      connect(idUser);
    });
  }

  void stopReconnecting() {
    channel?.sink.close();
    timer?.cancel();
  }
}