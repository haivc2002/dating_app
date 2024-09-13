import 'dart:ui';

import 'package:dating/bloc/bloc_home/home_bloc.dart';
import 'package:dating/common/textstyles.dart';
import 'package:dating/common/time_now.dart';
import 'package:dating/controller/all_tap_controller.dart';
import 'package:dating/theme/theme_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:swipable_stack/swipable_stack.dart';

import '../../../theme/theme_color.dart';
import '../setting/setting_screen.dart';
import '../profile/edit_profile_screen.dart';

class DrawerWidget extends StatefulWidget {
  final Function(bool) updateDrawerStatus;
  final AnimationController? animationController;
  final SwipableStackController swiController;
  final Function() onRefresh;
  const DrawerWidget({
    Key? key,
    this.animationController,
    required this.updateDrawerStatus,
    required this.swiController,
    required this.onRefresh,
  }) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {

  late AllTapController controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.updateDrawerStatus(true);
    });
    controller = AllTapController(context);
  }

  @override
  void dispose() {
    super.dispose();
    widget.updateDrawerStatus(false);
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Row(
      children: [
        Drawer(
          surfaceTintColor: Colors.transparent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          backgroundColor: Colors.transparent,
          child: Stack(
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                child: const SizedBox(),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                    color: themeNotifier.systemText.withOpacity(0.1),
                    border: Border(
                      right: BorderSide(
                        color: ThemeColor.greyColor.withOpacity(0.1)
                      )
                    )
                ),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    SizedBox(
                      height: 100.w,
                    ),
                    BlocBuilder<HomeBloc, HomeState>(
                      builder: (context, state) {
                        if(state.isLoading!) {
                          return ListTile(
                            leading: const CircleAvatar(),
                            title: Text(TimeNow.helloDate(), style: TextStyles.defaultStyle.whiteText.setTextSize(16.sp)),
                            subtitle: const Text('Loading...'),
                            trailing: TimeNow.iconDate(),
                          );
                        } else {
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage('${state.info?.listImage?[0].image}'),
                            ),
                            title: Text(TimeNow.helloDate(), style: TextStyles.defaultStyle.whiteText.setTextSize(16.sp)),
                            subtitle: Text('${state.info?.info?.name}', style: TextStyles
                                .defaultStyle
                                .setColor(themeNotifier.systemText)
                            ),
                            trailing: TimeNow.iconDate(),
                          );
                        }
                      }
                    ),
                    itemDrawer(CupertinoIcons.profile_circled, 'Edit Personal information', () {Navigator.pushNamed(context, EditProfileScreen.routeName);}),
                    itemDrawer(Icons.settings,'Setting', () async {
                      await Navigator.pushNamed(context, SettingScreen.routeName);
                      widget.onRefresh();
                      widget.swiController.currentIndex = 0;
                    }),
                    itemDrawer(Icons.logout,'Sign Out', ()=> controller.onSignOut()),
                  ],
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
              widget.animationController?.reverse();
            },
            child: Container(color: Colors.transparent)
          )
        )
      ],
    );
  }

  Widget itemDrawer(IconData iconData, String titleItem, Function() onTap) {
    return ListTile(
      leading: Icon(iconData, color: ThemeColor.whiteColor),
      title: Text(titleItem, style: const TextStyle(color: ThemeColor.whiteColor)),
      trailing: Icon(Icons.arrow_forward_ios, size: 11.sp, color: ThemeColor.greyColor,),
      onTap: () {
        Navigator.pop(context);
        onTap();
        setState(() {
          widget.animationController?.reverse();
        });
      },
    );
  }
}
