
import 'package:dating/bloc/bloc_all_tap/get_location_bloc.dart';
import 'package:dating/common/scale_screen.dart';
import 'package:dating/theme/theme_color.dart';
import 'package:dating/theme/theme_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../theme/theme_notifier.dart';
import '../../bloc/bloc_all_tap/all_tap_bloc.dart';
import '../../controller/all_tap_controller/all_tap_controller.dart';
import 'all_tap/drawer/drawer_widget.dart';
import 'all_tap/home/home_screen.dart';
import 'all_tap/premium/premium_screen.dart';
import 'all_tap/profile/profile_screen.dart';


class AllTapBottomScreen extends StatefulWidget {
  static const String routeName = 'allTapDrawerScreen';
  const AllTapBottomScreen({Key? key}) : super(key: key);

  @override
  State<AllTapBottomScreen> createState() => _AllTapBottomScreenState();
}

class _AllTapBottomScreenState extends State<AllTapBottomScreen> with TickerProviderStateMixin {

  late AnimationController animationController;
  late Animation<double> animation;
  late ThemeNotifier themeNotifier;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  late AllTapController controller = AllTapController(context);
  bool drawerStatus = false;

  @override
  void initState() {
    super.initState();
    controller = AllTapController(context);
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    animation = Tween<double>(begin: 1.0, end: 0.9).animate(animationController);
    controller.getData();
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    themeNotifier = Provider.of<ThemeNotifier>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scaffoldKey.currentState != null) {
        if (scaffoldKey.currentState!.isDrawerOpen) {
          drawerStatus = true;
        } else {
          drawerStatus = false;
        }
      }
    });
    drawerStatus != false
        ? animationController.forward()
        : animationController.reverse();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      drawerStatus == false;
    });
  }

  updateDrawerStatus(bool status) {
    setState(() {
      drawerStatus = status;
    });
    if (status) {
      animationController.forward();
    } else {
      animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      backgroundColor: themeNotifier.systemThemeFade,
      drawer: DrawerWidget(updateDrawerStatus: updateDrawerStatus, animationController: animationController),
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
                    PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: controller.pageController,
                      children: [
                        HomeScreen(animationController: animationController, openDrawer: controller.openDrawer, buildContext: context),
                        const PremiumScreen(),
                        SizedBox(),
                        const ProfileScreen(),
                      ],
                    ),
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
      child: Container(
        decoration: BoxDecoration(
          color: ThemeColor.blackColor.withOpacity(0.9),
          borderRadius: BorderRadius.circular(10.w),
          border: Border.all(
            color: ThemeColor.whiteColor.withOpacity(0.2),
            width: 1.5
          )
        ),
        height: 55.w,
        child: BlocBuilder<AllTapBloc, AllTapState>(
            builder: (context, state) {
              return Row(
                children: [
                  buttonBottom(state, Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: state.selectedIndex != 0 ? Colors.transparent : Colors.red,
                                blurRadius: 25.w
                              )
                            ]
                        ),
                        child: Icon(
                          state.selectedIndex == 0 ? Icons.favorite : Icons.favorite_border_outlined,
                          color: state.selectedIndex == 0 ? ThemeColor.redColor: ThemeColor.whiteColor,
                        ),
                      ),
                    () => controller.onItemTapped(0)
                  ),
                  buttonBottom(state, Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: state.selectedIndex != 1 ? Colors.transparent : Colors.yellow,
                                blurRadius: 25.w
                            )
                          ]
                      ),
                      child: Image.asset(
                        state.selectedIndex == 1 ? ThemeIcon.starBoldIcon : ThemeIcon.starLineIcon,
                        height: 22.w,
                        color: state.selectedIndex == 1 ? null : Colors.white,
                      ),
                    ),
                    () => controller.onItemTapped(1)
                  ),
                  buttonBottom(state, Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: state.selectedIndex != 2 ? Colors.transparent : Colors.blue,
                                blurRadius: 25.w
                            )
                          ]
                      ),
                      child: Image.asset(
                        state.selectedIndex == 2 ? ThemeIcon.messageBoldIcon : ThemeIcon.messageLineIcon,
                        height: 15.w,
                        color: state.selectedIndex == 2 ? null : Colors.white,
                      ),
                    ),
                    () => controller.onItemTapped(2)
                  ),
                  buttonBottom(state, Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: state.selectedIndex != 3 ? Colors.transparent : ThemeColor.pinkColor,
                                blurRadius: 25.w
                            )
                          ]
                      ),
                      child: Icon(
                        state.selectedIndex == 3 ? Icons.person : Icons.person_outline,
                        color: state.selectedIndex == 3 ? ThemeColor.pinkColor : ThemeColor.whiteColor,
                      ),
                    ),
                    () => controller.onItemTapped(3)
                  ),
                ],
              );
            }
        ),
      ),
    );
  }

  Widget buttonBottom(AllTapState state, Widget child, Function() onTap) {
    return Expanded(
        child: InkWell(
          borderRadius: BorderRadius.circular(10.w),
          onTap: onTap,
          child: Container(
            color: Colors.transparent,
            height: 55.w,
            child: Center(
              child: child,
            )
          ),
        )
    );
  }

}
