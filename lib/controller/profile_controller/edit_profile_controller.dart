
import 'package:dating/bloc/bloc_all_tap/get_location_bloc.dart';
import 'package:dating/bloc/bloc_profile/edit_bloc.dart';
import 'package:dating/common/scale_screen.dart';
import 'package:dating/common/textstyles.dart';
import 'package:dating/theme/theme_color.dart';
import 'package:dating/tool_widget_custom/bottom_sheet_custom.dart';
import 'package:dating/tool_widget_custom/button_widget_custom.dart';
import 'package:dating/tool_widget_custom/input_custom.dart';
import 'package:dating/tool_widget_custom/list_tile_custom.dart';
import 'package:dating/tool_widget_custom/popup_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../theme/theme_notifier.dart';
import '../../tool_widget_custom/list_tile_check_circle.dart';
import 'model_list_purpose.dart';


class EditProfileController {
  BuildContext context;
  EditProfileController(this.context);

  List<ModelListPurpose> listPurpose = [
    ModelListPurpose('Dating', Icons.wine_bar_sharp, 'I want to date and have fun with that person. That\'s all'),
    ModelListPurpose('Talk', Icons.chat_bubble, 'I want to chat and see where the relationship goes'),
    ModelListPurpose('Relationship', Icons.favorite, 'Find a long term relationship'),
  ];

  List<String> wineAndSmoking = ['Sometime', 'Usually', 'Have', 'Never', 'Undisclosed'];
  List<String> zodiac = ['Aries', 'Taurus', 'Gemini', 'Cancer', 'Leo', 'Virgo', 'Libra', 'Scorpius', 'Sagittarius', 'Capricorn', 'Aquarius', 'Pisces'];
  List<String> character = ['Introverted', 'Outward', 'Somewhere in the middle', 'Undisclosed'];

  List<String> listAcademicLevel = [
    'High School',
    'College',
    'University',
    'Master\'s Degree',
    'Doctoral Degree',
  ];

  void popupName() {
    PopupCustom.showPopup(context,
      title: 'Name',
      textEnable: 'Apply',
      textDisable: 'Cancel',
      content: Column(
        children: [
          contentRow('Name', SizedBox()),
          InputCustom(
            colorInput: ThemeColor.themeDarkFadeSystem.withOpacity(0.1),
            colorText: ThemeColor.blackColor,
          ),
          contentRow('Birthday', SizedBox()),
          contentRow('Location', BlocBuilder<GetLocationBloc, GetLocationState>(builder: (context, state) {
            if(state is LoadGetLocationState) {
              return const CircularProgressIndicator();
            } else if (state is SuccessGetLocationState) {
              return Text('${state.response[0].city}');
            } else {
              return const Text('Error');
            }
          })),
        ],
      ),
      function: () {

      }
    );
  }

  void popupWork() {
    PopupCustom.showPopup(
      context,
      title: 'Company name',
      content: InputCustom(
        colorInput: ThemeColor.themeDarkFadeSystem.withOpacity(0.1),
        colorText: ThemeColor.blackColor,
      ),
      function: () {}
    );
  }

  void popupAbout() {
    PopupCustom.showPopup(
      context,
      title: 'A little about yourself',
      content: Column(
        children: [
          Text('Don\'t hesitate', style: TextStyles.defaultStyle),
          InputCustom(
            maxLines: 8,
            colorInput: ThemeColor.blackColor.withOpacity(0.1),
            colorText: ThemeColor.blackColor,
            maxLength: 200,
          ),
        ],
      ),
      function: () {}
    );
  }

  void popupPurpose() {
    BottomSheetCustom.showCustomBottomSheet(
      context,
      height: heightScreen(context)*0.7,
      backgroundColor: ThemeColor.whiteColor.withOpacity(0.5),
      SizedBox(
        height: heightScreen(context)*0.6,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(children: [
                    Text('Tell everyone why you\'re here',
                      style: TextStyles.defaultStyle.bold.setTextSize(22.sp),
                      textAlign: TextAlign.center,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.w),
                            child: BlocBuilder<EditBloc, EditState>(builder: (context, state) {
                              return ListTileCustom(
                                color: state.indexPurpose != index ? ThemeColor.whiteColor.withOpacity(0.3) : ThemeColor.pinkColor.withOpacity(0.3),
                                title: listPurpose[index].title,
                                iconLeading: listPurpose[index].iconLeading,
                                iconTrailing: state.indexPurpose != index ? Icons.circle_outlined : Icons.check_circle,
                                subtitle: listPurpose[index].subtitle,
                                onTap: () {
                                  context.read<EditBloc>().add(EditEvent(indexPurpose: index));
                                },
                              );
                              }
                            ),
                          );
                        }
                    ),
                  ]),
                )
              ),
              BlocBuilder<EditBloc, EditState>(builder: (context, state) {
                  return ButtonWidgetCustom(
                    textButton: 'Apply',
                    styleText: TextStyles.defaultStyle.bold.whiteText,
                    color: ThemeColor.blackColor,
                    radius: 100.w,
                    onTap: () {
                      context.read<EditBloc>().add(EditEvent(purposeValue: listPurpose[state.indexPurpose??0].title));
                      Navigator.pop(context);
                    },
                  );
                }
              ),
            ],
          ),
        ),
      )
    );
  }

  Widget contentRow(String title, Widget widget) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.w),
      child: Row(
        children: [
          Text(title),
          const Spacer(),
          widget,
        ],
      ),
    );
  }

  void popupAcademicLevel() {
    BottomSheetCustom.showCustomBottomSheet(
      context,
      height: heightScreen(context)*0.5,
      backgroundColor: ThemeColor.whiteColor.withOpacity(0.5),
      Column(
        children: [
          Text('Academic level', style: TextStyles.defaultStyle.setTextSize(22.sp).bold,),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(listAcademicLevel.length, (index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
                    child: BlocBuilder<EditBloc, EditState>(builder: (context, state) {
                      bool isSelect = state.indexLevel != index;
                      return ListTileCheckCircle(
                        color: isSelect ? ThemeColor.whiteColor.withOpacity(0.3) : ThemeColor.pinkColor.withOpacity(0.5),
                        titleColor: isSelect ? ThemeColor.blackColor : ThemeColor.whiteColor,
                        iconColor: isSelect ? ThemeColor.blackColor : ThemeColor.whiteColor,
                        title: listAcademicLevel[index],
                        iconData: isSelect ? CupertinoIcons.circle : Icons.check_circle,
                        onTap: ()=> context.read<EditBloc>().add(EditEvent(indexLevel: index)),
                      );
                      }
                    ),
                  );
                }),
              ),
            ),
          )
        ],
      )
    );
  }

  Widget listHeight(int index) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    if(index == 0) {
      return Text('lower 100cm', textAlign: TextAlign.center, style: TextStyles.defaultStyle.setColor(themeNotifier.systemText),);
    } else if (index == 100) {
      return Text('higher 200cm', textAlign: TextAlign.center, style: TextStyles.defaultStyle.setColor(themeNotifier.systemText),);
    } else {
      return Text('${index+100}cm', textAlign: TextAlign.center, style: TextStyles.defaultStyle.setColor(themeNotifier.systemText),);
    }
  }
}