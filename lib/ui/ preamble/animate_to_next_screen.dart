import 'package:dating/theme/theme_color.dart';
import 'package:dating/ui/%20preamble/slider_screen.dart';
import 'package:flutter/material.dart';

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
    if (_animationPlayed == true) {
      Future.delayed(const Duration(milliseconds: 500), () {
        controller.forward();
      });
    } else {
      controller.dispose();
    }
  }

  late final AnimationController controller = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  );

  late final Animation<double> animation = CurvedAnimation(
    parent: controller,
    curve: Curves.fastOutSlowIn,
  ).drive(Tween<double>(
    begin: 0.7,
    end: 1.0,
  ));

  bool _animationPlayed = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: const Color(0xFF2B2B2B),
          body: Stack(
            children: [
              Center(
                child: AnimatedBuilder(
                  animation: animation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: animation.value,
                      child: child,
                    );
                  },
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: const SliderScreen()
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: filterBlur,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black.withOpacity(fadeColor),
                ),
              ),
              Column(
                children: [
                  AnimatedContainer(
                    height: containerHeight,
                    width: MediaQuery.of(context).size.width,
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
                            height: MediaQuery.of(context).size.height * 0.1,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                              colors: [
                                ThemeColor.pinkColor.withOpacity(0),
                                ThemeColor.pinkColor
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            )),
                          ),
                        ),
                        Container(
                          color: ThemeColor.pinkColor,
                          height: MediaQuery.of(context).size.height,
                        ),
                      ],
                    ),
                  ))
                ],
              ),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
