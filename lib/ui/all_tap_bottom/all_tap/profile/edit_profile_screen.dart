

import 'dart:io';

import 'package:dating/common/scale_screen.dart';
import 'package:dating/theme/theme_color.dart';
import 'package:dating/theme/theme_system.dart';
import 'package:dating/tool_widget_custom/appbar_custom.dart';
import 'package:dating/tool_widget_custom/item_add_image.dart';
import 'package:dating/tool_widget_custom/item_card.dart';
import 'package:dating/ui/all_tap_bottom/all_tap/profile/service/access_photo_gallery.dart';
import 'package:dating/ui/all_tap_bottom/all_tap/profile/service/bloc/upload_image_bloc.dart';
import 'package:dating/common/textstyles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileScreen extends StatefulWidget {
  static const String routeName = 'editProfileScreen';

  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late AccessPhotoGallery accessPhotoGallery;

  @override
  void initState() {
    super.initState();
    accessPhotoGallery = AccessPhotoGallery(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeSystem.systemTheme,
      body: AppBarCustom(
        title: 'Edit profile',
        textStyle: TextStyles.defaultStyle.bold.appbarTitle,
        bodyListWidget: [
          Container(
            height: widthScreen(context),
            width: widthScreen(context),
            padding: EdgeInsets.all(10.w),
            color: ThemeColor.themeDarkFadeSystem,
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Hero(
                          tag: 'keyAVT',
                          child: BlocBuilder<UploadImageBloc, UploadImageState>(
                              builder: (context, state) {
                                return Center(
                                  child: ItemAddImage(
                                    size: widthScreen(context)*0.60,
                                    backgroundUpload: state.imageUpload?[0],
                                    onTap: () {
                                      accessPhotoGallery.selectImage(0);
                                    },
                                  ),
                                );
                              }
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(child: itemAddImage(() {
                              accessPhotoGallery.selectImage(1);
                            }, 1)),
                            Expanded(child: itemAddImage(() {accessPhotoGallery.selectImage(2);}, 2)),
                          ],
                        )
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(child: itemAddImage(() {accessPhotoGallery.selectImage(3);}, 3)),
                      Expanded(child: itemAddImage(() {accessPhotoGallery.selectImage(4);}, 4)),
                      Expanded(child: itemAddImage(() {accessPhotoGallery.selectImage(5);}, 5)),
                    ],
                  ),
                ),
              ],
            )
          ),
          itemInfo(),
          itemInfoMore()
        ],
      ),
    );
  }

  Widget itemAddImage(Function() onTap, int? index) {
    return BlocBuilder<UploadImageBloc, UploadImageState>(
      builder: (context, state) {
        File? backgroundUpload;
        if (state.imageUpload != null && index != null && index < state.imageUpload!.length) {
          backgroundUpload = state.imageUpload![index];
        }
        return Center(
          child: ItemAddImage(
            size: widthScreen(context) * 0.28,
            backgroundUpload: backgroundUpload,
            onTap: onTap,
          ),
        );
      },
    );
  }

  Widget itemInfo() {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ItemCard(
            titleCard: 'Bùi Thanh Hải',
            listWidget: [
              Text('Hà nội', style: TextStyles.defaultStyle.whiteText,),
            ],
            iconRight: Icons.arrow_forward_ios,
          ),
          ItemCard(
            iconTitle: Icon(Icons.work_outline, color: ThemeColor.whiteColor.withOpacity(0.4)),
            titleCard: 'Work',
            listWidget: [Text('data', style: TextStyles.defaultStyle.whiteText)],
            iconRight: Icons.arrow_forward_ios,
          ),
          ItemCard(
            iconTitle: Icon(Icons.home_work_outlined, color: ThemeColor.whiteColor.withOpacity(0.4)),
            titleCard: 'Education',
            listWidget: [Text('đại học', style: TextStyles.defaultStyle.whiteText)],
            iconRight: Icons.arrow_forward_ios,
          ),
          ItemCard(
            iconTitle: Icon(CupertinoIcons.square_stack_3d_up, color: ThemeColor.whiteColor.withOpacity(0.4)),
            titleCard: 'Why are you here?',
            listWidget: [Text('Hẹn hò', style: TextStyles.defaultStyle.whiteText)],
            iconRight: Icons.arrow_forward_ios,
          ),
          ItemCard(
            iconTitle: Icon(Icons.edit_outlined, color: ThemeColor.whiteColor.withOpacity(0.4)),
            titleCard: 'A little about yourself',
            listWidget: [Text('làgweiufgiwe', style: TextStyles.defaultStyle.whiteText)],
            iconRight: Icons.arrow_forward_ios,
          ),
          Text('More information about me', style: TextStyles.defaultStyle.bold.setTextSize(17.sp).setColor(ThemeColor.pinkColor))
        ],
      ),
    );
  }

  Widget itemInfoMore() {
    return Container(
      color: ThemeColor.themeDarkFadeSystem,
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            itemComponentInfoMore(Icons.height, 'height', '180cm'),
            itemComponentInfoMore(Icons.wine_bar, 'wine', 'không uống rựu'),
            itemComponentInfoMore(Icons.language, 'language', 'Tiếng việt'),
            itemComponentInfoMore(Icons.smoking_rooms, 'smoking', 'Không thuốc lá'),
            itemComponentInfoMore(Icons.ac_unit_sharp, 'Zodiac', 'nhân mã'),
            itemComponentInfoMore(Icons.account_balance, 'Religion', 'vô thần'),
            itemComponentInfoMore(Icons.person, 'Character', 'hướng nội'),
          ],
        ),
      ),
    );
  }

  Widget itemComponentInfoMore(IconData iconData, String title, String data) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 20.w),
      child: Row(
        children: [
          Icon(iconData, color: ThemeColor.whiteColor.withOpacity(0.4)),
          SizedBox(width: 10.w),
          Text(title, style: TextStyles.defaultStyle.whiteText.bold),
          const Spacer(),
          Text(data, style: TextStyles.defaultStyle.whiteText,),
          SizedBox(width: 20.w)
        ],
      ),
    );
  }
}
