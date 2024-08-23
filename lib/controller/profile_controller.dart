import 'package:dating/bloc/bloc_home/home_bloc.dart';
import 'package:dating/common/textstyles.dart';
import 'package:dating/theme/theme_notifier.dart';
import 'package:dating/tool_widget_custom/button_widget_custom.dart';
import 'package:dating/ui/profile/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../model/model_info_user.dart';
import '../theme/theme_color.dart';
import 'home_controller.dart';

class ProfileController {
  BuildContext context;

  ProfileController(this.context);

  Widget checkNull(HomeState state, String keyValue) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    TextStyle style = TextStyles.defaultStyle.setColor(themeNotifier.systemText);
    Widget defaultState = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5.w),
          child: ButtonWidgetCustom(
            textButton: 'isEmpty',
            styleText: TextStyles.defaultStyle.bold.setColor(themeNotifier.systemTheme),
            color: themeNotifier.systemText.withOpacity(0.6),
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            radius: 100.w,
            onTap: ()=> Navigator.pushNamed(context, EditProfileScreen.routeName),
          ),
        ),
      ],
    );
    if((state.info?.info?.word != null && state.info?.info?.word != '') && keyValue == 'work') {
      return Text('${state.info?.info?.word}', style: style);
    } else if((state.info?.info?.academicLevel != null && state.info?.info?.academicLevel != '') && keyValue == 'academicLevel') {
      return Text('${state.info?.info?.academicLevel}', style: style);
    }
    else {
      return defaultState;
    }
  }

  List<Widget> items(ModelInfoUser data) {
    List<Widget> result = [];

    if (data.infoMore?.height != null) {
      result.add(_itemMore(Icons.height, '${data.infoMore?.height}cm'));
    }
    if (data.infoMore?.wine != null) {
      result.add(_itemMore(Icons.wine_bar, '${data.infoMore?.wine}'));
    }
    if (data.infoMore?.smoking != null) {
      result.add(_itemMore(Icons.smoking_rooms, '${data.infoMore?.smoking}'));
    }
    if (data.infoMore?.zodiac != null) {
      result.add(_itemMore(Icons.ac_unit_sharp, '${data.infoMore?.zodiac}'));
    }
    if (data.infoMore?.religion != null) {
      result.add(_itemMore(Icons.account_balance, '${data.infoMore?.religion}'));
    }
    if (data.infoMore?.hometown != null) {
      result.add(_itemMore(Icons.home, '${data.infoMore?.hometown}'));
    }

    return result;
  }

  Widget _itemMore(IconData iconData, String data) {
    return Container(
      decoration: BoxDecoration(
          color: ThemeColor.whiteColor,
          borderRadius: BorderRadius.circular(100.w)
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 12.w),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(iconData),
            SizedBox(width: 5.w),
            Text(data),
          ],
        ),
      ),
    );
  }

  void getInfo() async {
    HomeController homeController = HomeController(context);
    await homeController.getInfo();
  }
}