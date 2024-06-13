import 'dart:ui';

import 'package:dating/common/scale_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../../theme/theme_notifier.dart';

class PopupTypeHero extends StatefulWidget {
  static const String routeName = 'selectHeightPerson';

  final dynamic tag;
  final IconData? iconTitle;
  final double? height, width;
  final Widget content;
  final String? title, data;

  const PopupTypeHero(
      {Key? key,
      required this.tag,
      this.iconTitle,
      this.height,
      this.width,
      this.title,
      this.data,
      required this.content})
      : super(key: key);

  @override
  State<PopupTypeHero> createState() => _PopupTypeHeroState();
}

class _PopupTypeHeroState extends State<PopupTypeHero>
    with SingleTickerProviderStateMixin {
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
    _animation = Tween<double>(begin: 0, end: 10).animate(_controller);
    _opaCityBackground =
        Tween<double>(begin: 0.0, end: 0.6).animate(_controller);

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Stack(
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
            tag: widget.tag,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Material(
                color: themeNotifier.systemThemeFade,
                child: SizedBox(
                  height: widget.height ?? heightScreen(context) / 2,
                  width: widget.width ?? widthScreen(context) * 0.8,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 10.w),
                        child: Row(
                          children: [
                            Icon(widget.iconTitle,
                                color: themeNotifier.systemText),
                            SizedBox(width: 10.w),
                            Text(widget.title ?? '',
                                style: TextStyle(
                                    color: themeNotifier.systemText,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Text(widget.data ?? '',
                                  maxLines: 1,
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      color: themeNotifier.systemText,
                                      fontWeight: FontWeight.bold)),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(15.w, 0, 15.w, 20.w),
                          child: widget.content
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
