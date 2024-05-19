import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconButtonCustom extends StatelessWidget {
  final Color? backgroundColor;
  const IconButtonCustom({
    Key? key,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(1000.w),
        child: Material(
          color: backgroundColor ?? Colors.transparent,
          child: InkWell(
            onTap: () {},
            child: SizedBox(
              height: 30.w,
              width: 30.w,
              child: const Center(
              ),
            ),
          ),
        ),
      ),
    );
  }
}
