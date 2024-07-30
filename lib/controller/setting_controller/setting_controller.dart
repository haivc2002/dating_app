import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

import '../../common/global.dart';
import '../../theme/theme_notifier.dart';
import '../../theme/theme_rive.dart';

class SettingController {
  BuildContext context;
  SettingController(this.context);

  bool isDarkMode = Global.getBool('theme', def: false);
  double currentDistance = 1;
  RiveFile? fileRive;

  void toggleTheme(setState) {
    setState(() {
      isDarkMode = !isDarkMode;
      Global.setBool('theme', isDarkMode);
      Provider.of<ThemeNotifier>(context, listen: false).toggleTheme();
      triggerAnimation();
    });
  }

  late SMITrigger? light;
  late SMITrigger? dark;

  StateMachineController getRiveController(Artboard artBoard) {
    StateMachineController? riveController = StateMachineController.fromArtboard(artBoard, 'State Machine 1');
    artBoard.addController(riveController!);
    return riveController;
  }

  void triggerAnimation() {
    if (isDarkMode) {
      dark?.fire();
    } else {
      light?.fire();
    }
  }

  double sizeMap() {
    double result = 0;
    result = currentDistance/5;
    return 14 - result;
  }

  Future<void> preload(setState) async {
    rootBundle.load(ThemeRive.darkLight,).then((data) async {
      setState(() {
        fileRive = RiveFile.import(data);
      });
      },
    );
  }

}