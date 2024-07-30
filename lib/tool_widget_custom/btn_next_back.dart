import 'package:dating/common/textstyles.dart';
import 'package:dating/theme/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BtnNextBack extends StatelessWidget {
  final String title;
  final Function()? onTap;
  const BtnNextBack({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: ()=> Navigator.pop(context),
            child: Container(
              height: 50.w,
              width: 50.w,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: ThemeColor.whiteColor
              ),
              child: const Center(
                child: Icon(Icons.arrow_back_ios_new),
              ),
            ),
          ),
          SizedBox(width: 20.w),
          Expanded(
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                height: 50.w,
                decoration: BoxDecoration(
                  color: ThemeColor.pinkColor,
                  borderRadius: BorderRadius.circular(100.w),
                  boxShadow: [
                    BoxShadow(
                      color: ThemeColor.blackColor.withOpacity(0.3),
                      offset: const Offset(5, 5),
                      blurRadius: 10,
                    ),
                  ]
                ),
                child: Center(
                  child: Text(title, style: TextStyles.defaultStyle.bold.setTextSize(18.sp).whiteText),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
