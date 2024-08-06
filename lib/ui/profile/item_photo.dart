import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../theme/theme_color.dart';
import '../../theme/theme_notifier.dart';

class ItemPhoto extends StatelessWidget {
  final double? size;
  final void Function()? onTap;
  final String? backgroundUpload;
  const ItemPhoto({
    Key? key,
    this.size,
    this.onTap,
    this.backgroundUpload,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.w),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: size ?? 80.w,
          width: size ?? 80.w,
          decoration: BoxDecoration(
            color: themeNotifier.systemTheme,
            image: backgroundUpload != null
                ? DecorationImage(
              image: imageValue(),
              fit: BoxFit.cover,
            ) : null,
          ),
          child: backgroundUpload == null
              ? Center(
            child: Icon(
              Icons.add,
              size: 50.sp,
              color: ThemeColor.greyColor,
            ),
          ) : const SizedBox.shrink(),
        ),
      ),
    );
  }

  ImageProvider imageValue() {
    if(backgroundUpload!.startsWith('http')) {
      return NetworkImage(backgroundUpload!);
    } else {
      return FileImage(File(backgroundUpload!));
    }
  }
}


