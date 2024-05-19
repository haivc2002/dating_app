import 'dart:ui';

import 'package:dating/ui/all_tap_bottom/all_tap/profile/edit_profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../theme/theme_color.dart';

class DrawerWidget extends StatefulWidget {
  final Function(bool) updateDrawerStatus;
  final AnimationController? animationController;
  const DrawerWidget({
    Key? key,
    this.animationController,
    required this.updateDrawerStatus
  }) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.updateDrawerStatus(true);
    });
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.updateDrawerStatus(false);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                child: Container(),
              ),
              Container(
                decoration: BoxDecoration(
                    color: ThemeColor.whiteColor.withOpacity(0.1),
                    border: Border(
                        right: BorderSide(
                            color: ThemeColor.greyColor.withOpacity(0.1)
                        )
                    )
                ),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Container(
                      height: 100,
                    ),
                    itemDrawer(CupertinoIcons.profile_circled, 'Edit Personal information'),
                    itemDrawer(Icons.settings,'Setting'),
                    itemDrawer(Icons.logout,'Sign Out'),
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

  Widget itemDrawer(IconData iconData, String titleItem) {
    return ListTile(
      leading: Icon(iconData, color: ThemeColor.whiteColor),
      title: Text(titleItem, style: const TextStyle(color: ThemeColor.whiteColor)),
      trailing: Icon(Icons.arrow_forward_ios, size: 11.sp, color: ThemeColor.greyColor,),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, EditProfileScreen.routeName);
        setState(() {
          widget.animationController?.reverse();
        });
      },
    );
  }
}
