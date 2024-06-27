import 'dart:ui';

import 'package:dating/common/scale_screen.dart';
import 'package:dating/theme/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PressPopupCustom extends StatefulWidget {
  final Function()? onTap, onLongPress;
  final Widget child;
  final bool? shrink;
  final Widget content;
  final Color? colorCart;
  const PressPopupCustom({
    Key? key,
    this.onLongPress,
    required this.child,
    this.shrink,
    this.onTap,
    this.colorCart,
    required this.content,
  }) : super(key: key);

  @override
  State<PressPopupCustom> createState() => _PressPopupCustomState();
}

class _PressPopupCustomState extends State<PressPopupCustom> {
  double _scale = 1.0;

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _scale = widget.shrink == true ? 0.95 : 1.2;
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

  String keyHero = DateTime.now().toString();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onTap: nextScreen,
      onLongPress: () {
        HapticFeedback.vibrate();
        nextScreen();
      },
      child: AnimatedScale(
        scale: _scale,
        curve: Curves.fastOutSlowIn,
        duration: const Duration(milliseconds: 500),
        child: Hero(
          tag: keyHero,
          child: widget.child
        ),
      ),
    );
  }

  void nextScreen() {
    Navigator.push(context, PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, _, __) {
        return CartPopup(content: widget.content, colorCart: widget.colorCart, keyHero: keyHero);
      },
    ));
  }
}

class CartPopup extends StatefulWidget {
  final Widget content;
  final Color? colorCart;
  final String? keyHero;
  const CartPopup({Key? key, required this.content, this.colorCart, this.keyHero}) : super(key: key);

  @override
  State<CartPopup> createState() => _CartPopupState();
}

class _CartPopupState extends State<CartPopup> with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _opaCityBackground;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween<double>(begin: 0, end: 5).animate(_controller);
    _opaCityBackground = Tween<double>(begin: 0.0, end: 0.4).animate(_controller);
    _controller.forward();
  }
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              if(WidgetsBinding.instance.window.viewInsets.bottom > 0.0) {
                FocusScope.of(context).unfocus();
              } else {
                Navigator.pop(context);
                _controller.reverse();
              }
            },
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return BackdropFilter(
                  filter: ImageFilter.blur(
                      sigmaX: _animation.value, sigmaY: _animation.value),
                  child: Container(
                    color: Colors.black.withOpacity(_opaCityBackground.value),
                  ),
                );
              },
            ),
          ),
          Center(
            child: Hero(
              tag: '${widget.keyHero}',
              child: Container(
                width: widthScreen(context)*0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.w),
                  color: widget.colorCart ?? themeNotifier.systemThemeFade,
                ),
                constraints: BoxConstraints(
                  maxHeight: heightScreen(context)/2
                ),
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Material(
                    color: Colors.transparent,
                    child: widget.content,
                  ),
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}



