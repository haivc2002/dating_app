import 'package:dating/common/scale_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/theme_color.dart';

class EventScaleScreen extends StatefulWidget {
  final Widget child;
  final AnimationService animationService;
  final bool? shrink;
  const EventScaleScreen({
    Key? key,
    required this.child,
    required this.animationService,
    this.shrink,
  }) : super(key: key);

  static void showBottomSheet(BuildContext context, AnimationService animationService, Function(bool) setShrink, Widget widget) {
    final animationController = animationService.controller;
    final animationControllerBack = animationService.controllerBack;
    setShrink(true);
    animationController.forward(from: 0.0);
    showModalBottomSheet(
      isDismissible: false,
      context: context,
      barrierColor: ThemeColor.blackColor.withOpacity(0.3),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ContentBottomSheet(
          widget: widget,
        );
      },
    );
  }

  // animationControllerBack.forward(from: 0.0);
  // Navigator.pop(context);



  @override
  State<EventScaleScreen> createState() => _EventScaleScreenState();
}

class _EventScaleScreenState extends State<EventScaleScreen> with TickerProviderStateMixin {

  late AnimationService animationService;

  @override
  void initState() {
    super.initState();
    // animationService = AnimationService(this);
    animationService = widget.animationService;
  }

  @override
  void dispose() {
    animationService.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: AnimatedBuilder(
        animation: widget.shrink ?? true == true ? animationService.animation : animationService.animationBack,
        builder: (context, child) {
          return Transform.scale(
            scale: widget.shrink ?? true == true ? animationService.animation.value : animationService.animationBack.value,
            child: child,
          );
        },
        child: widget.child,
      ),
    );
  }


  // void showBottomSheet(BuildContext context, Function(bool) setShrink, Widget widget) {
  //   setShrink(true);
  //   animationService.controller.forward(from: 0.0);
  //   showModalBottomSheet(
  //     isDismissible: false,
  //     context: context,
  //     barrierColor: ThemeColor.blackColor.withOpacity(0.3),
  //     isScrollControlled: true,
  //     builder: (BuildContext context) {
  //       return ContentBottomSheet(
  //         widget: widget,
  //       );
  //     },
  //   );
  // }

  static void showBottomSheet(BuildContext context, AnimationService animationService, Function(bool) setShrink, Widget widget) {
    final animationController = animationService.controller;
    final animationControllerBack = animationService.controllerBack;
    setShrink(true);
    animationController.forward(from: 0.0);
    showModalBottomSheet(
      isDismissible: false,
      context: context,
      barrierColor: ThemeColor.blackColor.withOpacity(0.3),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ContentBottomSheet(
          widget: widget,
        );
      },
    );
  }
}

class AnimationService {
  late final AnimationController controller;
  late final Animation<double> animation;
  late final AnimationController controllerBack;
  late final Animation<double> animationBack;

  AnimationService(TickerProvider vsync) {
    controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: vsync,
    );

    controllerBack = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: vsync,
    );

    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.fastOutSlowIn,
    ).drive(Tween<double>(
      begin: 1,
      end: 0.85,
    ));

    animationBack = CurvedAnimation(
      parent: controllerBack,
      curve: Curves.fastOutSlowIn,
    ).drive(Tween<double>(
      begin: 0.85,
      end: 1,
    ));
  }

  void dispose() {
    controller.dispose();
    controllerBack.dispose();
  }
}

class ContentBottomSheet extends StatelessWidget {
  final Widget? widget;
  const ContentBottomSheet({Key? key, this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15)
      ),
      child: Material(
        child: Container(
          color: ThemeColor.whiteColor,
          height: heightScreen(context) * 0.9,
          width: widthScreen(context),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.h),
                height: 4.h,
                width: 50.w,
                decoration: BoxDecoration(
                  color: ThemeColor.greyColor,
                  borderRadius: BorderRadius.circular(100)
                ),
              ),
              widget ?? const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

class TestHelper {
  static void printSample(BuildContext context, AnimationService animationService, Function(bool) setShrink, Widget widget) {
    _EventScaleScreenState.showBottomSheet(context, animationService, setShrink, widget);
  }
}
