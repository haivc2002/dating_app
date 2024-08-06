
import 'dart:ui';

import 'package:dating/bloc/bloc_home/home_bloc.dart';
import 'package:dating/bloc/bloc_profile/edit_bloc.dart';
import 'package:dating/common/remove_province.dart';
import 'package:dating/common/scale_screen.dart';
import 'package:dating/common/textstyles.dart';
import 'package:dating/controller/home_controller.dart';
import 'package:dating/controller/profile_controller/update_model.dart';
import 'package:dating/model/model_info_user.dart';
import 'package:dating/service/access_photo_gallery.dart';
import 'package:dating/theme/theme_color.dart';
import 'package:dating/tool_widget_custom/bottom_sheet_custom.dart';
import 'package:dating/tool_widget_custom/button_widget_custom.dart';
import 'package:dating/tool_widget_custom/input_custom.dart';
import 'package:dating/tool_widget_custom/list_tile_custom.dart';
import 'package:dating/tool_widget_custom/popup_custom.dart';
import 'package:dating/tool_widget_custom/wait.dart';
import 'package:dating/ui/profile/item_photo.dart';
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

  List<String> listAcademicLevel = [
    'High school',
    'College',
    'University',
    'Master\'s degree',
    'Doctoral degree',
    'Empty'
  ];

  TextEditingController nameController = TextEditingController();
  TextEditingController workController = TextEditingController();
  TextEditingController aboutController = TextEditingController();

  void popupName(SuccessApiHomeState state) {
    nameController.text = '${state.info?.info?.name}';
    PopupCustom.showPopup(context,
      title: 'Name',
      content: Column(
        children: [
          contentRow('Name', const SizedBox()),
          InputCustom(
            controller: nameController,
            colorInput: ThemeColor.themeDarkFadeSystem.withOpacity(0.1),
            colorText: ThemeColor.blackColor,
          ),
          contentRow('Birthday', Text('${state.info?.info?.birthday}')),
          contentRow('Location', BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
            if(state is LoadApiHomeState) {
              return Wait(size: 15.w,strokeWidth: 2.w);
            } else if (state is SuccessApiHomeState) {
              return Text(_city(state));
            } else {
              return const Text('Error');
            }
          })),
        ],
      ),
      listAction: [
        Text('Cancel', style: TextStyles.defaultStyle.setColor(ThemeColor.redColor)),
        Text('Yes', style: TextStyles.defaultStyle.setColor(ThemeColor.blueColor).bold),
      ],
      listOnPress: [
        ()=>Navigator.pop(context),
        ()=>activatedName(state, nameController.text),
      ]
    );
  }

  String _city(SuccessApiHomeState state) {
    if(state.location?[0].state != null) {
      return RemoveProvince.cancel('${state.location?[0].state}');
    } else if(state.location?[0].city != null) {
      return '${state.location?[0].city}';
    } else {
      return 'Unknown';
    }
  }

  void popupWork(SuccessApiHomeState state) {
    if(state.info?.info?.word != null) {
      workController.text = '${state.info?.info?.word}';
    } else {
      workController.text = '';
    }
    PopupCustom.showPopup(
      context,
      title: 'Company name',
      content: InputCustom(
        controller: workController,
        colorInput: ThemeColor.themeDarkFadeSystem.withOpacity(0.1),
        colorText: ThemeColor.blackColor,
      ),
      listAction: [
        Text('Cancel', style: TextStyles.defaultStyle.setColor(ThemeColor.redColor)),
        Text('Yes', style: TextStyles.defaultStyle.setColor(ThemeColor.blueColor).bold),
      ],
      listOnPress: [
        ()=>Navigator.pop(context),
        ()=>activatedWork(state, workController.text)
      ]
    );
  }

  void popupAbout(SuccessApiHomeState state) {
    if(state.info?.info?.describeYourself != null) {
      aboutController.text = '${state.info?.info?.describeYourself}';
    } else {
      aboutController.text = '';
    }
    PopupCustom.showPopup(
      context,
      title: 'A little about yourself',
      content: Column(
        children: [
          Text('Don\'t hesitate', style: TextStyles.defaultStyle),
          InputCustom(
            controller: aboutController,
            maxLines: 8,
            colorInput: ThemeColor.blackColor.withOpacity(0.1),
            colorText: ThemeColor.blackColor,
            maxLength: 200,
          ),
        ],
      ),
      listAction: [
        Text('Cancel', style: TextStyles.defaultStyle.setColor(ThemeColor.redColor)),
        Text('Yes', style: TextStyles.defaultStyle.setColor(ThemeColor.blueColor).bold),
      ],
      listOnPress: [
        ()=>Navigator.pop(context),
        ()=>activatedAbout(state, aboutController.text)
      ]
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
                    BlocBuilder<HomeBloc, HomeState>(
                      builder: (context, state) {
                        if(state is SuccessApiHomeState) {
                          String purposeValue = '${state.info?.info?.desiredState}';
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              int indexCurrent = listPurpose[index].title.indexOf(purposeValue);
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.w),
                                child: ListTileCustom(
                                  color: indexCurrent != 0 ? ThemeColor.whiteColor.withOpacity(0.3) : ThemeColor.pinkColor.withOpacity(0.3),
                                  title: listPurpose[index].title,
                                  iconLeading: listPurpose[index].iconLeading,
                                  iconTrailing: indexCurrent != 0 ? Icons.circle_outlined : Icons.check_circle,
                                  subtitle: listPurpose[index].subtitle,
                                  onTap: () => activatedPurpose(index, state)
                                )
                              );
                            }
                          );
                        } else {
                          return const SizedBox();
                        }
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
      ),
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
            child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
              if(state is SuccessApiHomeState) {
                String academicLevelValue = '${state.info?.info?.academicLevel}';
                int indexCurrent = listAcademicLevel.indexOf(academicLevelValue);
                return SingleChildScrollView(
                  child: Column(
                    children: List.generate(listAcademicLevel.length, (index) {
                      bool isSelect = indexCurrent != index;
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
                        child: ListTileCheckCircle(
                          color: isSelect ? ThemeColor.whiteColor.withOpacity(0.3) : ThemeColor.pinkColor.withOpacity(0.5),
                          titleColor: isSelect ? ThemeColor.blackColor : ThemeColor.whiteColor,
                          iconColor: isSelect ? ThemeColor.blackColor : ThemeColor.whiteColor,
                          title: listAcademicLevel[index],
                          iconData: isSelect ? CupertinoIcons.circle : Icons.check_circle,
                          onTap: () => activatedAcademicLevel(index, state)
                        ),
                      );
                    }),
                  ),
                );
              } else {
                return const SizedBox();
              }
            })
          )
        ],
      )
    );
  }

  void activatedAcademicLevel(int index, SuccessApiHomeState state) {
    UpdateModel.updateModelInfo(
      state.info!,
      academicLevel: listAcademicLevel[index]
    );
    context.read<HomeBloc>().add(SuccessApiHomeEvent(info: UpdateModel.modelInfoUser));
  }

  void activatedName(SuccessApiHomeState state, String nameValue) {
    UpdateModel.updateModelInfo(
      state.info!,
      name: nameValue
    );
    context.read<HomeBloc>().add(SuccessApiHomeEvent(info: UpdateModel.modelInfoUser));
    Navigator.pop(context);
  }

  void activatedWork(SuccessApiHomeState state, String workValue) {
    UpdateModel.updateModelInfo(
      state.info!,
      work: workValue
    );
    context.read<HomeBloc>().add(SuccessApiHomeEvent(info: UpdateModel.modelInfoUser));
    Navigator.pop(context);
  }

  void activatedAbout(SuccessApiHomeState state, String aboutValue) {
    UpdateModel.updateModelInfo(
      state.info!,
      describeYourself: aboutValue,
    );
    context.read<HomeBloc>().add(SuccessApiHomeEvent(info: UpdateModel.modelInfoUser));
    Navigator.pop(context);
  }

  void activatedPurpose(int index, SuccessApiHomeState state) {
    UpdateModel.updateModelInfo(
      state.info!,
      desiredState: listPurpose[index].title
    );
    context.read<HomeBloc>().add(SuccessApiHomeEvent(info: UpdateModel.modelInfoUser));
  }

  void getInfo() async {
    HomeController homeController = HomeController(context);
    await homeController.getInfo();
  }

  void onOption(ListImage imageView, int index) {
    AccessPhotoGallery gallery = AccessPhotoGallery(context);
    double size = 150.w;
    BottomSheetCustom.showCustomBottomSheet(
      height: 350.w,
      blur: 0,
      backgroundColor: Colors.transparent,
      context,
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Center(child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.w),
                    child: SizedBox(
                      height: size+30,
                      width: widthScreen(context),
                      child: ImageFiltered(
                        imageFilter: ImageFilter.blur(sigmaY: 15, sigmaX: 15),
                        child: ItemPhoto(
                          size: size,
                          backgroundUpload: imageView.image,
                        ),
                      ),
                    ),
                  )),
                  Center(
                    child: SizedBox(
                      height: size+30,
                      width: widthScreen(context),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.w),
                          color: ThemeColor.whiteColor.withOpacity(0.2)
                        )
                      ),
                    ),
                  ),
                  Center(
                    child: ItemPhoto(
                      size: size,
                      backgroundUpload: imageView.image,
                    ),
                  ),
                ],
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                  color: ThemeColor.whiteIos,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10.w))
              ),
              child: ListTile(
                  title: const Text('Replace', style: TextStyle(color: ThemeColor.blueColor)),
                  leading: const Icon(Icons.edit, color: ThemeColor.blueColor),
                  onTap: () {
                    gallery.updateImage(index);
                    Navigator.pop(context);
                  }
              ),
            ),
            ColoredBox(
              color: ThemeColor.whiteIos.withOpacity(0.9),
              child: SizedBox(height: 1, width: widthScreen(context)),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                  color: ThemeColor.whiteIos,
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(10.w))
              ),
              child: ListTile(
                title: const Text('Delete', style: TextStyle(color: ThemeColor.redColor)),
                leading: const Icon(Icons.delete_forever_rounded, color: ThemeColor.redColor),
                onTap: ()=> gallery.deleteImage(index),
              ),
            )
          ],
        ),
      )
    );
  }

  void backAndUpdate() {
    getInfo();
    Navigator.pop(context);
    print(UpdateModel.modelInfoUser.toJson());
  }
}