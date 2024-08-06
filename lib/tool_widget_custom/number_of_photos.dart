import 'package:dating/theme/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NumberOfPhotos extends StatelessWidget {
  final int? count, currentPage;
  const NumberOfPhotos({super.key, this.count, this.currentPage});


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20.w,
      child: Row(
        children: List.generate(count??0, (index) {
          if(count == 1) {
            return const SizedBox();
          } else {
            return Expanded(
                child: Container(
                  height: 5.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.w),
                    color: currentPage == index ? ThemeColor.whiteColor : ThemeColor.blackColor.withOpacity(0.5),
                    border: Border.all(color: ThemeColor.whiteColor.withOpacity(0.5))
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 3.w),
                )
            );
          }
        }),
      )
    );
  }
}
