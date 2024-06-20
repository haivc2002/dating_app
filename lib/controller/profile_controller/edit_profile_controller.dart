
import 'package:dating/bloc/bloc_all_tap/get_location_bloc.dart';
import 'package:dating/bloc/bloc_profile/edit_bloc.dart';
import 'package:dating/common/scale_screen.dart';
import 'package:dating/common/textstyles.dart';
import 'package:dating/theme/theme_color.dart';
import 'package:dating/tool_widget_custom/bottom_sheet_custom.dart';
import 'package:dating/tool_widget_custom/button_widget_custom.dart';
import 'package:dating/tool_widget_custom/input_custom.dart';
import 'package:dating/tool_widget_custom/list_title_custom.dart';
import 'package:dating/tool_widget_custom/popup_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'model_list_purpose.dart';


class EditProfileController {
  BuildContext context;
  EditProfileController(this.context);

  List<ModelListPurpose> listPurpose = [
    ModelListPurpose('Dating', Icons.wine_bar_sharp, 'I want to date and have fun with that person. That\'s all'),
    ModelListPurpose('Talk', Icons.chat_bubble, 'I want to chat and see where the relationship goes'),
    ModelListPurpose('Relationship', Icons.favorite, 'Find a long term relationship'),
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
                                color: state.indexPurpose != index ? ThemeColor.whiteColor.withOpacity(0.3) : ThemeColor.pinkColor.withOpacity(0.2),
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
                    onTap: ()=> context.read<EditBloc>().add(EditEvent(purposeValue: listPurpose[state.indexPurpose??0].title)),
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
}