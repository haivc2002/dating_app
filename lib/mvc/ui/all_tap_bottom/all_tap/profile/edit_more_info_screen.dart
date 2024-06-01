import 'package:dating/mvc/ui/all_tap_bottom/all_tap/profile/bloc/edit_more_bloc.dart';
import 'package:dating/mvc/ui/all_tap_bottom/all_tap/profile/select_height_person.dart';
import 'package:dating/theme/theme_color.dart';
import 'package:dating/tool_widget_custom/appbar_custom.dart';
import 'package:dating/tool_widget_custom/hero_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_hero/local_hero.dart';
import 'package:provider/provider.dart';

import '../../../../../common/textstyles.dart';
import '../../../../../theme/theme_notifier.dart';

class EditMoreInfoScreen extends StatefulWidget {
  static const String routeName = 'editMoreInfoScreen';
  const EditMoreInfoScreen({Key? key}) : super(key: key);

  @override
  State<EditMoreInfoScreen> createState() => _EditMoreInfoScreenState();
}

class _EditMoreInfoScreenState extends State<EditMoreInfoScreen> {

  List<String> wine = ['Sometime', 'Usually', 'Have', 'Never', 'Undisclosed'];
  AlignmentGeometry alignment = Alignment.topLeft;
  bool test = false;


  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      backgroundColor: themeNotifier.systemTheme,
      body: AppBarCustom(
        title: 'Edit more information',
        textStyle: TextStyles.defaultStyle.appbarTitle.bold,
        bodyListWidget: [
          SizedBox(height: 50.w),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, SelectHeightPerson.routeName);
            },
            child: itemComponentInfoMore(
              Icons.height, 'height', '180cm', 1,
              const SizedBox()
            ),
          ),
          BlocBuilder<EditMoreBloc, EditMoreState>(
            builder: (context, state) {
              return itemComponentInfoMore(
                Icons.wine_bar, 'wine', '${state.wine}', 2,
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 20.w, 0, 0),
                  child: Wrap(
                    runSpacing: 10.w,
                    spacing: 10.w,
                    children: List.generate(wine.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          context.read<EditMoreBloc>().add(EditMoreEvent(wine: wine[index]));
                        },
                        child: options(wine[index], wine[index] == state.wine)
                      );
                    }),
                  ),
                )
              );
            }
          ),
          itemComponentInfoMore(
            Icons.smoking_rooms, 'smoking', 'Không thuốc lá', 4,
            Wrap(
              children: List.generate(4, (index) => Text('data')),
            )
          ),
          itemComponentInfoMore(
            Icons.ac_unit_sharp, 'Zodiac', 'nhân mã', 5,
            Text('data')
          ),
          itemComponentInfoMore(
            Icons.account_balance, 'Religion', 'vô thần', 6,
            Text('data')
          ),
          itemComponentInfoMore(
            Icons.person, 'Character', 'hướng nội', 7,
            Text('data')
          ),
          itemComponentInfoMore(
            Icons.home, 'Hometown', 'Thái bình', 8,
            Text('data')
          ),
        ],
      ),
    );
  }

  Widget itemComponentInfoMore(IconData iconData, String title, String data, int key, Widget widget) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 20.w),
      child: HeroCustom(
        title: title,
        iconLeading: iconData,
        data: data,
        keyHero: key,
        widget: widget,
      ),
    );
  }

  Widget options(String title, bool condition) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Container(
      decoration: BoxDecoration(
        color: condition ? ThemeColor.pinkColor : ThemeColor.greyColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(100.w)
      ),
      padding: EdgeInsets.symmetric(vertical: 7.w, horizontal: 10.w),
      child: Text(title, style: TextStyles.defaultStyle.setColor(condition ? ThemeColor.whiteColor : themeNotifier.systemText)),
    );
  }
}
