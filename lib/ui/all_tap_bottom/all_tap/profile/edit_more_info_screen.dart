
import 'package:dating/theme/theme_color.dart';
import 'package:dating/tool_widget_custom/appbar_custom.dart';
import 'package:dating/tool_widget_custom/hero_custom.dart';
import 'package:dating/tool_widget_custom/press_hold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../common/textstyles.dart';
import '../../../../../theme/theme_notifier.dart';
import '../../../../bloc/bloc_profile/edit_more_bloc.dart';
import 'additional_screen/select_height_person.dart';
import 'additional_screen/set_hometown.dart';
import 'common_local/return_height_value.dart';
import 'package:flutter/services.dart';

class EditMoreInfoScreen extends StatefulWidget {
  static const String routeName = 'editMoreInfoScreen';
  const EditMoreInfoScreen({Key? key}) : super(key: key);

  @override
  State<EditMoreInfoScreen> createState() => _EditMoreInfoScreenState();
}

class _EditMoreInfoScreenState extends State<EditMoreInfoScreen> {

  List<String> wineAndSmoking = ['Sometime', 'Usually', 'Have', 'Never', 'Undisclosed'];
  List<String> zodiac = ['Aries', 'Taurus', 'Gemini', 'Cancer', 'Leo', 'Virgo', 'Libra', 'Scorpius', 'Sagittarius', 'Capricorn', 'Aquarius', 'Pisces'];
  List<String> character = ['Introverted', 'Outward', 'Somewhere in the middle', 'Undisclosed'];
  AlignmentGeometry alignment = Alignment.topLeft;

  @override
  void initState() {
    super.initState();
  }


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
          PressHold(
            function: ()=> Navigator.pushNamed(context, SelectHeightPerson.routeName),
            onTap: ()=> Navigator.pushNamed(context, SelectHeightPerson.routeName),
            child: BlocBuilder<EditMoreBloc, EditMoreState>(
              builder: (context, state) {
                return itemComponentInfoMore(
                  Icons.height, 'height', '${returnHeightValue(state.heightPerson??0)}cm', 1,
                  const SizedBox()
                );
              }
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
                    children: List.generate(wineAndSmoking.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          context.read<EditMoreBloc>().add(EditMoreEvent(wine: wineAndSmoking[index]));
                        },
                        child: options(wineAndSmoking[index], wineAndSmoking[index] == state.wine)
                      );
                    }),
                  ),
                )
              );
            }
          ),
          BlocBuilder<EditMoreBloc, EditMoreState>(
            builder: (context, state) {
              return itemComponentInfoMore(
                Icons.smoking_rooms, 'smoking', '${state.smoking}', 4,
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 20.w, 0, 0),
                    child: Wrap(
                      runSpacing: 10.w,
                      spacing: 10.w,
                      children: List.generate(wineAndSmoking.length, (index) {
                        return GestureDetector(
                            onTap: () {
                              context.read<EditMoreBloc>().add(EditMoreEvent(smoking: wineAndSmoking[index]));
                            },
                            child: options(wineAndSmoking[index], wineAndSmoking[index] == state.smoking)
                        );
                      }),
                    ),
                  )
              );
            }
          ),
          BlocBuilder<EditMoreBloc, EditMoreState>(
            builder: (context, state) {
              return itemComponentInfoMore(
                Icons.ac_unit_sharp, 'Zodiac', '${state.zodiac}', 5,
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 20.w, 0, 0),
                  child: Wrap(
                    runSpacing: 10.w,
                    spacing: 10.w,
                    children: List.generate(zodiac.length, (index) {
                      return GestureDetector(
                          onTap: () {
                            context.read<EditMoreBloc>().add(EditMoreEvent(zodiac: zodiac[index]));
                          },
                          child: options(zodiac[index], zodiac[index] == state.zodiac)
                      );
                    }),
                  ),
                )
              );
            }
          ),
          itemComponentInfoMore(
            Icons.account_balance, 'Religion', 'vô thần', 6,
            Text('♈data')
          ),
          BlocBuilder<EditMoreBloc, EditMoreState>(
            builder: (context, state) {
              return itemComponentInfoMore(
                Icons.person, 'Character', '${state.character}', 7,
                Column(
                  children: List.generate(character.length, (index) {
                    return GestureDetector(
                      onTap: () => context.read<EditMoreBloc>().add(EditMoreEvent(character: character[index])),
                      child: Container(
                        decoration: BoxDecoration(
                          color: themeNotifier.systemTheme,
                          borderRadius: BorderRadius.circular(100.w)
                        ),
                        padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 20.w),
                        margin: EdgeInsets.symmetric(vertical: 5.w, horizontal: 20.w),
                        child: Row(
                          children: [
                            Text(character[index], style: TextStyles.defaultStyle.setColor(state.character == character[index] ? ThemeColor.pinkColor : themeNotifier.systemText).bold),
                            const Spacer(),
                            state.character == character[index]
                              ? const Icon(Icons.check_circle, color: ThemeColor.pinkColor)
                              : const SizedBox(),
                          ],
                        ),
                      ),
                    );
                  }),
                )
              );
            }
          ),
          PressHold(
            onTap: () => Navigator.pushNamed(context, SetHomeTown.routeName),
            function: () => Navigator.pushNamed(context, SetHomeTown.routeName),
            child: itemComponentInfoMore(
              Icons.home, 'Hometown', 'Thái bình', 8,
              const SizedBox()
            ),
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
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      decoration: BoxDecoration(
        color: condition ? ThemeColor.pinkColor : ThemeColor.greyColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(100.w)
      ),
      padding: EdgeInsets.symmetric(vertical: 7.w, horizontal: 10.w),
      child: Text(title, style: TextStyles.defaultStyle.setColor(condition ? ThemeColor.whiteColor : themeNotifier.systemText)),
    );
  }
}
