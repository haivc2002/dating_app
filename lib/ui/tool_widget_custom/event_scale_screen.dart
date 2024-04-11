import 'package:flutter/material.dart';

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

  @override
  State<EventScaleScreen> createState() => _EventScaleScreenState();
}

class _EventScaleScreenState extends State<EventScaleScreen> with TickerProviderStateMixin {

  late AnimationService animationService;

  @override
  void initState() {
    super.initState();
    animationService = widget.animationService;
  }

  @override
  void dispose() {
    animationService.dispose();
    super.dispose();
  }

  // void showBottom(bool? shrink) {
  //   setState(() {
  //     shrink = true;
  //   });
  //   animationService.controller.forward(from: 0.0);
  //   showModalBottomSheet(
  //     isDismissible: false,
  //     context: context,
  //     barrierColor: ThemeColor.blackColor.withOpacity(0.3),
  //     isScrollControlled: true,
  //     builder: (BuildContext context) {
  //       return GestureDetector(
  //         onTap: () {
  //           hideBottom();
  //         },
  //         child: Container(
  //           color: Colors.white,
  //           height: MediaQuery.of(context).size.height * 0.9,
  //         ),
  //       );
  //     },
  //   );
  // }


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