import 'package:dating/bloc/bloc_home/home_bloc.dart';
import 'package:dating/common/city_cover.dart';
import 'package:dating/common/scale_screen.dart';
import 'package:dating/common/year_old.dart';
import 'package:dating/controller/profile_controller.dart';
import 'package:dating/theme/theme_color.dart';
import 'package:dating/theme/theme_icon.dart';
import 'package:dating/theme/theme_image.dart';
import 'package:dating/tool_widget_custom/appbar_custom.dart';
import 'package:dating/common/textstyles.dart';
import 'package:dating/tool_widget_custom/button_widget_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../theme/theme_notifier.dart';
import '../../../tool_widget_custom/item_card.dart';
import '../setting/setting_screen.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  late ProfileController controller;

  @override
  void initState() {
    super.initState();
    controller = ProfileController(context);
  }


  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final colorIcon = themeNotifier.systemText.withOpacity(0.5);
    TextStyle style = TextStyles.defaultStyle.bold.setColor(themeNotifier.systemText);
    return Scaffold(
      backgroundColor: themeNotifier.systemTheme,
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, homeState) {
          if(homeState is SuccessApiHomeState) {
            return AppBarCustom(
              showLeading: false,
              title: 'My profile',
              textStyle: TextStyles.defaultStyle.bold.setColor(ThemeColor.pinkColor).setTextSize(18.sp),
              trailing: GestureDetector(
                onTap: () => Navigator.pushNamed(context, SettingScreen.routeName),
                child: Icon(Icons.settings, color: themeNotifier.systemText),
              ),
              bodyListWidget: [
                Container(
                  height: 300.w,
                  width: widthScreen(context),
                  color: themeNotifier.systemThemeFade,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 50.w),
                      Hero(tag: 'keyAVT',
                        child: CircleAvatar(
                          radius: 80.w,
                          backgroundImage: NetworkImage('${homeState.info?.listImage?[0].image}'),
                        )
                      ),
                      Expanded(child: Center(
                        child: Text(
                          '${homeState.info?.info?.name}, ${yearOld('${homeState.info?.info?.birthday}')}',
                          style: TextStyles.defaultStyle.bold.setColor(themeNotifier.systemText).setTextSize(20.sp),
                        ))
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal:  20.w, vertical: 10.w),
                  child: Row(
                    children: [
                      Text('about me', style: TextStyles.defaultStyle.bold.setTextSize(18.sp).setColor(themeNotifier.systemText)),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                            color: ThemeColor.themeDarkSystem,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: ThemeColor.whiteColor.withOpacity(0.1),
                                blurRadius: 8,
                                offset: Offset(-2.w, -2.w)
                              ),
                              BoxShadow(
                                color: ThemeColor.blackColor.withOpacity(0.5),
                                blurRadius: 8,
                                offset: Offset(4.w, 4.w)
                              ),
                            ]
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.edit, color: ThemeColor.whiteColor),
                          onPressed: () {
                            Navigator.pushNamed(context, EditProfileScreen.routeName);
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Container(
                    decoration: BoxDecoration(
                      color: themeNotifier.systemThemeFade,
                      borderRadius: BorderRadius.circular(10.w)
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          trailing: Text(cityCover(homeState), style: TextStyles.defaultStyle.setColor(themeNotifier.systemText)),
                          leading: Icon(CupertinoIcons.location_fill, color: colorIcon),
                          title: Text('Location', style: style),
                        ),
                        Divider(color: themeNotifier.systemText.withOpacity(0.04)),
                        ListTile(
                          trailing: controller.checkNull(homeState, 'work'),
                          leading: Icon(Icons.work, color: colorIcon),
                          title: Text('Work', style: style),
                        ),
                        Divider(color: themeNotifier.systemText.withOpacity(0.04)),
                        ListTile(
                          trailing: controller.checkNull(homeState, 'academicLevel'),
                          leading: Icon(Icons.school, color: colorIcon),
                          title: Text('AcademicLevel', style: style),
                        ),
                        Divider(color: themeNotifier.systemText.withOpacity(0.04)),
                        ListTile(
                          title: Text('Gender', style: style),
                          trailing: Text('${homeState.info?.info?.gender}', style: TextStyles.defaultStyle.setColor(themeNotifier.systemText)),
                          leading: SizedBox(
                            width: 20.w,
                            height: 20.w,
                            child: Image.asset(ThemeIcon.iconGender, color: colorIcon),
                          )
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.w),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: ItemCard(
                    titleCard: 'Describe yourself',
                    fontSize: 18.sp,
                    listWidget: [
                      SizedBox(
                        width: widthScreen(context)*0.77,
                        child: homeState.info?.info?.describeYourself != null
                            ? Text('${homeState.info?.info?.describeYourself}', style: TextStyles.defaultStyle.setColor(themeNotifier.systemText.withOpacity(0.6)))
                            : ButtonWidgetCustom(
                          textButton: 'Add',
                          radius: 100.w,
                          styleText: TextStyles.defaultStyle.bold.setColor(themeNotifier.systemTheme),
                          color: themeNotifier.systemText.withOpacity(0.6),
                          onTap: ()=> Navigator.pushNamed(context, EditProfileScreen.routeName),
                        )
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: ItemCard(
                    listWidget: [
                      SizedBox(
                        width: widthScreen(context)*0.77,
                        child: Wrap(
                          runSpacing: 8.w,
                          spacing: 8.w,
                          children: controller.items(homeState.info!)
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          } else {
            return _error();
          }
        }
      ),
    );
  }

  Widget _error() {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(ThemeImage.error, scale: 1.2),
          SizedBox(height: 30.w),
          Text('Error! Failed to load Data', style: TextStyles.defaultStyle.setColor(themeNotifier.systemText))
        ],
      ),
    );
  }
}
