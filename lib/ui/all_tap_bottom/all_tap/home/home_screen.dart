import 'package:dating/common/scale_screen.dart';
import 'package:dating/theme/theme_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:swipable_stack/swipable_stack.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late final SwipableStackController _controller;
  void _listenController() => setState(() {});
  List<Color> _images = [
    ThemeColor.redColor,
    Colors.black,
    ThemeColor.pinkColor,
  ];

  @override
  void initState() {
    super.initState();
    _controller = SwipableStackController()..addListener(_listenController);
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
    return Scaffold(
      backgroundColor: ThemeColor.backgroundScaffold,
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(8),
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
                      child: Stack(
                        children: [
                          Container(
                            height: heightScreen(context),
                            width: widthScreen(context),
                            color: _images[itemIndex],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            // BottomButtonsRow(
            //   onSwipe: (direction) {
            //     _controller.next(swipeDirection: direction);
            //   },
            //   onRewindTap: _controller.rewind,
            //   canRewind: _controller.canRewind,
            // ),
          ],
        ),
      ),
    );
  }
}
