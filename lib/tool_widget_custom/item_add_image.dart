// import 'dart:io';
//
// import 'package:dating/theme/theme_color.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class ItemAddImage extends StatelessWidget {
//   final double? size;
//   final void Function()? onTap;
//   final File? backgroundUpload;
//   const ItemAddImage({
//     Key? key,
//     this.size,
//     this.onTap,
//     this.backgroundUpload,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(10.w),
//       child: GestureDetector(
//         onTap: onTap,
//         child: Container(
//           height: size ?? 80.w,
//           width: size ?? 80.w,
//           decoration: BoxDecoration(
//             color: ThemeColor.backgroundScaffold,
//             image: backgroundUpload != null
//                 ? DecorationImage(
//                     image: FileImage(backgroundUpload!),
//                     fit: BoxFit.cover,
//                   )
//                 : null,
//           ),
//           child: backgroundUpload == null ? Center(
//             child: Icon(Icons.add, size: 50.sp, color: ThemeColor.greyColor,),
//           ) : const SizedBox.shrink(),
//         ),
//       ),
//     );
//   }
// }


import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/theme_color.dart';

class ItemAddImage extends StatelessWidget {
  final double? size;
  final void Function()? onTap;
  final File? backgroundUpload;
  const ItemAddImage({
    Key? key,
    this.size,
    this.onTap,
    this.backgroundUpload,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.w),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: size ?? 80.w,
          width: size ?? 80.w,
          decoration: BoxDecoration(
            color: ThemeColor.themeDarkSystem,
            image: backgroundUpload != null
                ? DecorationImage(
              image: FileImage(backgroundUpload!),
              fit: BoxFit.cover,
            )
                : null,
          ),
          child: backgroundUpload == null
              ? Center(
            child: Icon(
              Icons.add,
              size: 50.sp,
              color: ThemeColor.greyColor,
            ),
          )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }
}
