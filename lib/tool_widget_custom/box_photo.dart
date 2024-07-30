import 'dart:io';

import 'package:dating/common/textstyles.dart';
import 'package:dating/theme/theme_color.dart';
import 'package:dating/tool_widget_custom/button_widget_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../bloc/bloc_profile/edit_bloc.dart';
import '../common/scale_screen.dart';
import '../service/access_photo_gallery.dart';
import 'item_add_image.dart';

class BoxPhoto extends StatelessWidget {
  final Function(int index) function;
  const BoxPhoto({super.key, required this.function});

  @override
  Widget build(BuildContext context) {
    AccessPhotoGallery photoGallery = AccessPhotoGallery(context);
    return Column(
      children: [
        Container(
            height: widthScreen(context),
            width: widthScreen(context),
            padding: EdgeInsets.all(10.w),
            color: ThemeColor.themeLightFadeSystem,
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: BlocBuilder<EditBloc, EditState>(
                            builder: (context, state) {
                              return Center(
                                child: ItemAddImage(
                                  size: widthScreen(context)*0.60,
                                  backgroundUpload: setImage(state),
                                  onTap: ()=> function(0)
                                ),
                              );
                            }
                        ),
                      ),
                      Expanded(
                          child: Column(
                            children: [
                              Expanded(child: itemAddImage(() => function(1), 1)),
                              Expanded(child: itemAddImage(() => function(2), 2)),
                            ],
                          )
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(child: itemAddImage(()=> function(3), 3)),
                      Expanded(child: itemAddImage(()=> function(4), 4)),
                      Expanded(child: itemAddImage(()=> function(5), 5)),
                    ],
                  ),
                ),
              ],
            )
        ),
        ButtonWidgetCustom(
          textButton: 'Remove last',
          styleText: TextStyles.defaultStyle.bold,
          color: ThemeColor.themeLightSystem,
          onTap: ()=> photoGallery.remove(),
        )
      ],
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

  File? setImage(EditState state) {
    if (state.imageUpload != null && state.imageUpload!.isNotEmpty) {
      return state.imageUpload![0];
    } else {
      return null;
    }
  }

}
