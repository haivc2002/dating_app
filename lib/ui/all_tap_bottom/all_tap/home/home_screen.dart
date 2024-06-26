import 'package:dating/common/scale_screen.dart';
import 'package:dating/theme/theme_color.dart';
import 'package:dating/tool_widget_custom/appbar_custom.dart';
import 'package:dating/tool_widget_custom/press_hold.dart';
import 'package:dating/ui/detail/detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:swipable_stack/swipable_stack.dart';

import '../../../../../common/textstyles.dart';
import '../../../../../theme/theme_notifier.dart';
import '../../../../common/global.dart';
import '../../../../controller/home_controller/home_controller.dart';

class HomeScreen extends StatefulWidget {
  final void Function(BuildContext) openDrawer;
  final BuildContext buildContext;
  final AnimationController animationController;
  const HomeScreen({
    Key? key,
    required this.openDrawer,
    required this.buildContext,
    required this.animationController
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late final SwipableStackController _controller;
  void _listenController() => setState(() {});
  late HomeController controller;
  bool isSwipingTutorial = Global.getBool('swipingTutorial', def: true);

  final List<Color> _images = [
    ThemeColor.redColor,
    Colors.black,
    ThemeColor.pinkColor,
  ];

  @override
  void initState() {
    super.initState();
    _controller = SwipableStackController()..addListener(_listenController);
    controller = HomeController(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      isSwipingTutorial ? controller.popupTutorial() : null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller
      ..removeListener(_listenController)
      ..dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Scaffold(
      backgroundColor: themeNotifier.systemThemeFade,
      body: SafeArea(
        top: false,
        child: AppBarCustom(
          title: 'Dash Date',
          leadingIcon: GestureDetector(
            onTap: () {
              widget.openDrawer(widget.buildContext);
              setState(() {
                widget.animationController.forward();
              });
            },
            child: Container(
              color: ThemeColor.whiteColor,
              child: const Center(
                child: Icon(Icons.menu),
              ),
            ),
          ),
          scrollPhysics: const NeverScrollableScrollPhysics(),
          textStyle: TextStyles.defaultStyle.bold.setColor(ThemeColor.pinkColor).setTextSize(18.sp),
          bodyListWidget: [
            SizedBox(
              height: heightScreen(context)*0.8,
              width: widthScreen(context),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: PressHold(
                        shrink: true,
                        function: () => Navigator.pushNamed(context, DetailScreen.routeName),
                        child: Hero(
                          tag: 'detail',
                          child: SwipableStack(
                            detectableSwipeDirections: const {
                              SwipeDirection.right,
                              SwipeDirection.left,
                            },
                            controller: _controller,
                            stackClipBehaviour: Clip.none,
                            onSwipeCompleted: (index, direction) {
                              if (kDebugMode) {
                                print('$index, $direction');
                              }
                            },
                            horizontalSwipeThreshold: 0.8,
                            verticalSwipeThreshold: 0.8,
                            builder: (context, properties) {
                              final itemIndex = properties.index % _images.length;
                              return Center(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.w),
                                  child: Container(
                                    color: _images[itemIndex],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      const Spacer(),
                      SizedBox(
                        height: 100.w,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }



}
