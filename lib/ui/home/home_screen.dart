import 'package:dating/argument_model/arguments_detail_model.dart';
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

import '../../../common/textstyles.dart';
import '../../../theme/theme_notifier.dart';
import '../../common/global.dart';
import '../../controller/home_controller/home_controller.dart';

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

  final List<String> _images = [
    'https://gcs.tripi.vn/public-tripi/tripi-feed/img/474014MTE/anh-gai-xinh-cute-de-thuong-hot-girl-5.jpg',
    'https://gcs.tripi.vn/public-tripi/tripi-feed/img/474014MTE/anh-gai-xinh-cute-de-thuong-hot-girl-5.jpg',
    'https://gcs.tripi.vn/public-tripi/tripi-feed/img/474014MTE/anh-gai-xinh-cute-de-thuong-hot-girl-5.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _controller = SwipableStackController()..addListener(_listenController);
    controller = HomeController(context);
    controller.getListNomination();
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
      backgroundColor: themeNotifier.systemTheme,
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
                        function: () => Navigator.pushNamed(
                          context,
                          DetailScreen.routeName,
                          arguments: ArgumentsDetailModel(keyHero: 0, controller: _controller)
                        ),
                        child: Hero(
                          tag: '0',
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
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(_images[itemIndex]),
                                        fit: BoxFit.cover,
                                      )
                                    ),
                                  )
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
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
