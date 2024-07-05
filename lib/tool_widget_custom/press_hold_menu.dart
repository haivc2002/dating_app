import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PressHoldMenu extends StatefulWidget {
  final Widget child;
  final List<String> menuAction;
  final Function()? onTap;
  final List<Function()> onPressedList;
  const PressHoldMenu({
    Key? key,
    required this.child,
    required this.menuAction,
    required this.onPressedList,
    this.onTap,
  }) : super(key: key);

  @override
  State<PressHoldMenu> createState() => _PressHoldMenuState();
}

class _PressHoldMenuState extends State<PressHoldMenu> {
  double _scale = 1.0;

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _scale = 1.2;
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
      onTap: widget.onTap,
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
          child: Column(children: [widget.child])
        ),
      ),
    );
  }

  void nextScreen() {
    Navigator.push(context, PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, _, __) {
        return CartMenu(
          keyHero: keyHero,
          menuAction: widget.menuAction,
          onPressedList: widget.onPressedList,
          child: widget.child
        );
      },
    ));
  }
}

class CartMenu extends StatefulWidget {
  final Widget child;
  final String keyHero;
  final List<String> menuAction;
  final List<Function()> onPressedList;
  const CartMenu({
    Key? key,
    required this.keyHero,
    required this.child,
    required this.menuAction,
    required this.onPressedList,
  }) : super(key: key);

  @override
  State<CartMenu> createState() => _CartMenuState();
}

class _CartMenuState extends State<CartMenu>  with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<double> _scaleAnimation;

  late Animation<double> _opaCityBackground;
  late Animation<double> _opaCityListMenu;
  double scale = 0.5;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fade = Tween<double>(begin: 0, end: 5).animate(_controller);
    _opaCityBackground = Tween<double>(begin: 0.0, end: 0.4).animate(_controller);
    _opaCityListMenu = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.forward();
  }

  void disablePressMenu() async {
    BuildContext currentContext = context;
    if(WidgetsBinding.instance.window.viewInsets.bottom > 0.0) {
      FocusScope.of(context).unfocus();
    } else {
      _controller.reverse();
      await Future.delayed(const Duration(milliseconds: 80));
      if(context.mounted) {
        Navigator.pop(currentContext);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          GestureDetector(
            onTap: ()=> disablePressMenu(),
            child: AnimatedBuilder(
              animation: _fade,
              builder: (context, child) {
                return BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: _fade.value, sigmaY: _fade.value),
                  child: Container(
                    color: Colors.black.withOpacity(_opaCityBackground.value),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Center(
              child: Hero(
                tag: widget.keyHero,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      widget.child,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50.w),
                        child: AnimatedBuilder(
                            animation: _controller,
                            builder: (context, child) {
                              return Transform.scale(
                                scale: _scaleAnimation.value,
                                child: Opacity(
                                  opacity: _opaCityListMenu.value,
                                  child: MediaQuery.removePadding(
                                    context: context,
                                    removeTop: true,
                                    child: ListView.builder(
                                        itemCount: widget.menuAction.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return ClipRRect(
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(index == 0 ? 10.w : 0),
                                              topLeft: Radius.circular(index == 0 ? 10.w : 0),
                                              bottomRight: Radius.circular(index == (widget.menuAction.length -1) ? 10.w : 0),
                                              bottomLeft: Radius.circular(index == widget.menuAction.length -1 ? 10.w : 0),
                                            ),
                                            child: CupertinoContextMenuAction(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                widget.onPressedList[index]();
                                              },
                                              child: Text(widget.menuAction[index]),
                                            ),
                                          );
                                        }
                                    ),
                                  ),
                                ),
                              );
                            }
                        ),
                      ),
                    ],
                  ),
                )
              ),
            )
          ),
        ],
      ),
    );
  }
}

