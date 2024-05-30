import 'package:dating/common/scale_screen.dart';
import 'package:dating/theme/theme_color.dart';
import 'package:dating/theme/theme_image.dart';
import 'package:dating/tool_widget_custom/appbar_custom.dart';
import 'package:dating/ui/all_tap_bottom/all_tap/profile/edit_profile_screen.dart';
import 'package:dating/common/textstyles.dart';
import 'package:dating/ui/setting/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../theme/theme_notifier.dart';
import '../../../../tool_widget_custom/item_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Scaffold(
      backgroundColor: themeNotifier.systemTheme,
      body: AppBarCustom(
        showLeading: false,
        title: 'My profile',
        textStyle: TextStyles.defaultStyle.bold.setColor(ThemeColor.pinkColor).setTextSize(18.sp),
        trailing: GestureDetector(
          onTap: () => Navigator.pushNamed(context, SettingScreen.routeName),
          child: Icon(Icons.settings, color: themeNotifier.systemText),
        ),
        bodyListWidget: [
          Container(
            height: heightScreen(context)*0.4,
            width: widthScreen(context),
            color: themeNotifier.systemThemeFade,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(tag: 'keyAVT',
                  child: CircleAvatar(
                    radius: 80.w,
                    backgroundImage: AssetImage(ThemeImage.backgroundLogin),
                  )
                ),
                SizedBox(height: 30.w),
                Text('Name')
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
            child: const Column(
              children: [
                ItemCard(
                  titleCard: 'ffff',
                ),
                ItemCard(),
                ItemCard(),
                ItemCard(),
                ItemCard(),
              ],
            ),
          )
        ],
      ),

    );
  }
}
