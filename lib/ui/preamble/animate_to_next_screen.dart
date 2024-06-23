import 'package:dating/common/scale_screen.dart';
import 'package:dating/theme/theme_color.dart';
import 'package:dating/ui/auth/login_screen.dart';
import 'package:flutter/material.dart';

import '../../../tool_widget_custom/scale_screen_animated.dart';

class AnimateToNextScreen extends StatefulWidget {
  const AnimateToNextScreen({Key? key}) : super(key: key);

  @override
  State<AnimateToNextScreen> createState() => _AnimateToNextScreenState();
}

class _AnimateToNextScreenState extends State<AnimateToNextScreen> with TickerProviderStateMixin {
  double containerHeight = 0;
  bool lineFade = false;
  bool filterBlur = true;
  double fadeColor = 0.8;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        lineFade = true;
        containerHeight = MediaQuery.of(context).size.height;
        fadeColor = 0.0;
      });
    });
    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {
        filterBlur = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: const Color(0xFF2B2B2B),
          body: Stack(
            children: [
              ScaleScreenAnimated(
                play: true,
                delay: const Duration(milliseconds: 300),
                zomScreen: true,
                child: SizedBox(
                  height: heightScreen(context),
                  width: widthScreen(context),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: const LoginScreen()
                  ),
                ),
              ),
              Visibility(
                visible: filterBlur,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  height: heightScreen(context),
                  width: widthScreen(context),
                  color: Colors.black.withOpacity(fadeColor),
                ),
              ),
              filterBlur ? Column(
                children: [
                  AnimatedContainer(
                    height: containerHeight,
                    width: widthScreen(context),
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                      children: [
                        Visibility(
                          visible: lineFade,
                          child: Container(
                            height: heightScreen(context) * 0.1,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                              colors: [
                                ThemeColor.pinkFadeColor.withOpacity(0),
                                ThemeColor.pinkFadeColor
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            )),
                          ),
                        ),
                        Container(
                          color: ThemeColor.pinkFadeColor,
                          height: heightScreen(context),
                        ),
                      ],
                    ),
                  ))
                ],
              ) : const SizedBox(),
            ],
          ),
        ));
  }
}
