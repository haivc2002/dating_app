import 'package:flutter/material.dart';

class ScaleScreenAnimated extends StatefulWidget {
  final Widget child;
  final Duration? delay;
  final bool? zomScreen, play;
  const ScaleScreenAnimated({
    Key? key,
    required this.child,
    this.delay,
    this.zomScreen,
    this.play
  }) : super(key: key);

  @override
  State<ScaleScreenAnimated> createState() => _ScaleScreenAnimatedState();
}

class _ScaleScreenAnimatedState extends State<ScaleScreenAnimated> with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    if (widget.play == true) {
      Future.delayed(widget.delay ?? const Duration(milliseconds: 0), () {
        controller.forward();
      });
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
    begin: widget.zomScreen == true ? 0.7 : 1,
    end: widget.zomScreen == true ? 1.0 : 0.7,
  ));

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return Transform.scale(
              scale: animation.value,
              child: child,
            );
          },
          child: widget.child,
        ),
      ),
    );
  }
}