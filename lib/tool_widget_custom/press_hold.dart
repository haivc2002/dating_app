import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PressHold extends StatefulWidget {
  final Function() function;
  final Function()? onTap;
  final Widget child;
  const PressHold({
    Key? key,
    required this.function,
    required this.child,
    this.onTap,
  }) : super(key: key);

  @override
  State<PressHold> createState() => _PressHoldState();
}

class _PressHoldState extends State<PressHold> {
  double _scale = 1.0;

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _scale = 0.95;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _scale = 1.0;
    });
  }

  void _handleTapCancel() async {
    setState(() {
      _scale = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onTap: widget.onTap,
      onLongPress: () {
        HapticFeedback.vibrate();
        widget.function();
      },
      child: AnimatedScale(
        scale: _scale,
        curve: Curves.fastOutSlowIn,
        duration: const Duration(milliseconds: 500),
        child: widget.child,
      ),
    );
  }
}
