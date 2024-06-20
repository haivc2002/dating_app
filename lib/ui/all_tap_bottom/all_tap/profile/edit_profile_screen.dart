

import 'dart:io';

import 'package:dating/common/scale_screen.dart';
import 'package:dating/theme/theme_color.dart';
import 'package:dating/tool_widget_custom/appbar_custom.dart';
import 'package:dating/tool_widget_custom/hero_custom.dart';
import 'package:dating/tool_widget_custom/item_add_image.dart';
import 'package:dating/tool_widget_custom/item_card.dart';
import 'package:dating/service/access_photo_gallery.dart';
import 'package:dating/common/textstyles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../theme/theme_notifier.dart';
import '../../../../bloc/bloc_profile/edit_bloc.dart';
import '../../../../controller/profile_controller/edit_profile_controller.dart';
import 'edit_more_info_screen.dart';

class EditProfileScreen extends StatefulWidget {
  static const String routeName = 'editProfileScreen';

  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late AccessPhotoGallery accessPhotoGallery;
  late EditProfileController controller;

  @override
  void initState() {
    super.initState();
    accessPhotoGallery = AccessPhotoGallery(context);
    controller = EditProfileController(context);
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Scaffold(
      backgroundColor: themeNotifier.systemTheme,
      body: AppBarCustom(
        title: 'Edit profile',
        textStyle: TextStyles.defaultStyle.bold.appbarTitle,
        bodyListWidget: [
          Container(
            height: widthScreen(context),
            width: widthScreen(context),
            padding: EdgeInsets.all(10.w),
            color: themeNotifier.systemThemeFade,
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
                          child: BlocBuilder<EditBloc, EditState>(
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
          itemInfoMore(themeNotifier)
        ],
      ),
    );
  }

  Widget itemAddImage(Function() onTap, int? index) {
    return BlocBuilder<EditBloc, EditState>(
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
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ItemCard(
            titleCard: 'Bùi Thanh Hải',
            listWidget: [
              Text('Hà nội', style: TextStyles.defaultStyle.setColor(themeNotifier.systemText),),
            ],
            iconRight: Icons.arrow_forward_ios,
            onTap: ()=> controller.popupName()
          ),
          ItemCard(
            iconTitle: Icon(Icons.work_outline, color: themeNotifier.systemText.withOpacity(0.4)),
            titleCard: 'Work',
            listWidget: [Text('data', style: TextStyles.defaultStyle.setColor(themeNotifier.systemText))],
            iconRight: Icons.arrow_forward_ios,
            onTap: ()=> controller.popupWork(),
          ),
          ItemCard(
            iconTitle: Icon(Icons.home_work_outlined, color: themeNotifier.systemText.withOpacity(0.4)),
            titleCard: 'Education',
            listWidget: [Text('đại học', style: TextStyles.defaultStyle.setColor(themeNotifier.systemText))],
            iconRight: Icons.arrow_forward_ios,
          ),
          ItemCard(
            iconTitle: Icon(CupertinoIcons.square_stack_3d_up, color: themeNotifier.systemText.withOpacity(0.4)),
            titleCard: 'Why are you here?',
            listWidget: [Text('Hẹn hò', style: TextStyles.defaultStyle.setColor(themeNotifier.systemText))],
            iconRight: Icons.arrow_forward_ios,
            onTap: ()=> controller.popupPurpose(),
          ),
          ItemCard(
            iconTitle: Icon(Icons.edit_outlined, color: themeNotifier.systemText.withOpacity(0.4)),
            titleCard: 'A little about yourself',
            listWidget: [Text('làgweiufgiwe', style: TextStyles.defaultStyle.setColor(themeNotifier.systemText))],
            iconRight: Icons.arrow_forward_ios,
            onTap: ()=> controller.popupAbout(),
          ),
          Text('More information about me', style: TextStyles.defaultStyle.bold.setTextSize(17.sp).setColor(ThemeColor.pinkColor))
        ],
      ),
    );
  }

  Widget itemInfoMore(ThemeNotifier themeNotifier) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, EditMoreInfoScreen.routeName);
      },
      child: Container(
        color: themeNotifier.systemThemeFade,
        child: Column(
          children: [
            itemComponentInfoMore(Icons.height, 'height', '180cm', 1),
            itemComponentInfoMore(Icons.wine_bar, 'wine', 'không uống rựu', 2),
            itemComponentInfoMore(Icons.smoking_rooms, 'smoking', 'Không thuốc lá', 4),
            itemComponentInfoMore(Icons.ac_unit_sharp, 'Zodiac', 'nhân mã', 5),
            itemComponentInfoMore(Icons.account_balance, 'Religion', 'vô thần', 6),
            itemComponentInfoMore(Icons.person, 'Character', 'hướng nội', 7),
            itemComponentInfoMore(Icons.home, 'Hometown', 'Thái bình', 8),
          ],
        ),
      ),
    );
  }

  Widget itemComponentInfoMore(IconData iconData, String title, String data, int key) {
    return HeroCustom(
      title: title,
      iconLeading: iconData,
      data: data,
      keyHero: key,
    );
  }
}