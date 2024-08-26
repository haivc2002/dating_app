
import 'package:dating/bloc/bloc_home/home_bloc.dart';
import 'package:dating/common/global.dart';
import 'package:dating/common/scale_screen.dart';
import 'package:dating/controller/home_controller.dart';
import 'package:dating/theme/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:swipable_stack/swipable_stack.dart';

import '../../../theme/theme_notifier.dart';
import '../../bloc/bloc_all_tap/all_tap_bloc.dart';
import '../../controller/all_tap_controller.dart';
import 'bottom_bar.dart';
import 'drawer_widget.dart';


class AllTapBottomScreen extends StatefulWidget {
  static const String routeName = 'allTapDrawerScreen';
  const AllTapBottomScreen({Key? key}) : super(key: key);

  @override
  State<AllTapBottomScreen> createState() => _AllTapBottomScreenState();
}

class _AllTapBottomScreenState extends State<AllTapBottomScreen> with TickerProviderStateMixin, RouteAware {

  late AnimationController animationController;
  late Animation<double> animation;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  late AllTapController controller = AllTapController(context);
  bool drawerStatus = false;
  late final SwipableStackController _controller;

  late HomeController homeController;

  @override
  void initState() {
    super.initState();
    controller = AllTapController(context);
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    animation = Tween<double>(begin: 1.0, end: 0.9).animate(animationController);
    if (scaffoldKey.currentState != null) {
      if (scaffoldKey.currentState!.isDrawerOpen) {
        drawerStatus = true;
      } else {
        drawerStatus = false;
      }
    }
    drawerStatus ? animationController.forward() : animationController.reverse();
    homeController = HomeController(context);
    final rangeValue = context.read<HomeBloc>().state.currentDistance;
    homeController.getData(rangeValue!);

    int currentIndex = context.read<HomeBloc>().state.currentIndex!;
    _controller = SwipableStackController(initialIndex: currentIndex)..addListener(_listenController);
  }

  void _listenController() => setState(() {});

  @override
  void dispose() {
    animationController.dispose();
    controller.channel?.sink.close();
    controller.timer?.cancel();
    _controller
      ..removeListener(_listenController)
      ..dispose();
    super.dispose();
  }

  updateDrawerStatus(bool status) {
    drawerStatus = status;
    context.read<AllTapBloc>().add(AllTapEvent(drawerStatus: drawerStatus));
    if (status) {
      animationController.forward();
    } else {
      animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    controller.continuous(Global.getInt(ThemeConfig.idUser).toString());
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      backgroundColor: themeNotifier.systemTheme,
      drawer: DrawerWidget(
        updateDrawerStatus: updateDrawerStatus,
        animationController: animationController,
        swiController: _controller,
        onRefresh: () {
          final rangeValue = context.read<HomeBloc>().state.currentDistance;
          homeController.getData(rangeValue!);
        },
      ),
      body: AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return Transform.scale(
              alignment: Alignment.centerRight,
              scale: animation.value,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.w),
                child: SizedBox(
                  height: heightScreen(context),
                  child: Stack(
                    children: [
                      BlocBuilder<AllTapBloc, AllTapState>(builder: (context, state) {
                        return controller.screenChange(state ,animationController, context, _controller);
                      }),
                      bottom(),
                    ],
                  ),
                ),
              ),
            );
          }
      ),
    );
  }

  Widget bottom() {
    return Positioned(
        left: 40.w,
        right: 40.w,
        bottom: 30.w,
        child: BottomBar(controller: controller)
    );
  }

}
