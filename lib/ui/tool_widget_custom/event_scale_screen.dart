import 'package:flutter/material.dart';

class EventScaleScreen extends StatefulWidget {
  final Widget child;
  final AnimationService animationService;
  const EventScaleScreen({
    Key? key,
    required this.child,
    required this.animationService,
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
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: AnimatedBuilder(
        animation: animationService.animation,
        builder: (context, child) {
          return Transform.scale(
            scale: animationService.animation.value,
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

  AnimationService(TickerProvider vsync) {
    controller = AnimationController(
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
    // controller.forward();
  }

  void dispose() {
    controller.dispose();
  }
}