import 'dart:ui';

import 'package:dating/theme/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../common/scale_screen.dart';

class PopupController {
  final VoidCallback open;
  final VoidCallback close;

  PopupController({
    required this.open,
    required this.close,
  });
}

class ExtensionBuild extends StatefulWidget {
  final Widget Function(PopupController) builder;
  final Widget extension;

  const ExtensionBuild({
    Key? key,
    required this.builder,
    required this.extension,
  }) : super(key: key);

  @override
  State<ExtensionBuild> createState() => _ExtensionBuildState();
}

class _ExtensionBuildState extends State<ExtensionBuild> with SingleTickerProviderStateMixin {
  late BuildContext bottomSheetContext;
  late AnimationController _controller;
  late Animation<double> _animation;
  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300)
    );
    _animation = Tween<double>(begin: 1, end: 0.9).animate(_controller);
  }

  void openPopup(double height, ThemeNotifier theme) {
    _controller.forward();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        bottomSheetContext = context;
        return ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(14.w)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
            child: Container(
              height: height,
              width: widthScreen(context),
              color: theme.systemTheme.withOpacity(0.5),
              child: Column(
                children: [
                  Container(
                    height: 5.w,
                    width: 50.w,
                    decoration: BoxDecoration(
                      color: theme.systemText.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(100.w)
                    ),
                    margin: EdgeInsets.symmetric(vertical: 10.w),
                  ),
                  Expanded(child: widget.extension),
                ],
              )
            ),
          ),
        );
      },
    ).then((_) => _controller.reverse());
  }

  void closePopup() {
    Navigator.pop(bottomSheetContext);
  }

  double initHeight = 0;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox renderBox = _key.currentContext?.findRenderObject() as RenderBox;
      final size = renderBox.size;
      initHeight = size.height;
    });

    final themeNotifier = Provider.of<ThemeNotifier>(context);

    final controller = PopupController(
      open: ()=> openPopup(initHeight*0.9, themeNotifier),
      close: closePopup,
    );
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value,
          alignment: Alignment.topCenter,
          child: Container(
            key: _key,
            child: widget.builder(controller)
          ),
        );
      }
    );
  }
}
