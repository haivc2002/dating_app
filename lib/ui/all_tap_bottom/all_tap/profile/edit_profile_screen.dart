import 'dart:io';

import 'package:dating/common/scale_screen.dart';
import 'package:dating/theme/theme_color.dart';
import 'package:dating/tool_widget_custom/appbar_custom.dart';
import 'package:dating/tool_widget_custom/item_add_image.dart';
import 'package:dating/ui/all_tap_bottom/all_tap/profile/service/access_photo_gallery.dart';
import 'package:dating/ui/extension/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileScreen extends StatefulWidget {
  static const String routeName = 'editProfileScreen';

  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  AccessPhotoGallery accessPhotoGallery = AccessPhotoGallery();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.backgroundScaffold,
      body: AppBarCustom(
        title: 'Edit profile',
        textStyle: TextStyles.defaultStyle.bold.appbarTitle,
        bodyListWidget: [
          Container(
            height: heightScreen(context) * 0.5,
            width: widthScreen(context),
            padding: EdgeInsets.all(10.w),
            color: ThemeColor.fadeScaffold,
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: itemAddImage()
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Expanded(child: itemAddImage()),
                            Expanded(child: itemAddImage()),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Expanded(child: itemAddImage()),
                      Expanded(child: itemAddImage()),
                      Expanded(child: itemAddImage()),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }


  Widget itemAddImage() {
    return Padding(
        padding: EdgeInsets.all(5.w),
        child: ItemAddImage(
          backgroundUpload: accessPhotoGallery.imageUpload,
          onTap: accessPhotoGallery.selectImage,
        )
    );
  }
}
