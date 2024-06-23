import 'package:dating/common/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../theme/theme_color.dart';
import '../theme/theme_notifier.dart';

class InputCustom extends StatelessWidget {
  final TextEditingController? controller;
  final Color? colorInput, colorText;
  final int? maxLines, maxLength;
  final String? labelText;
  final double? topRadius, bottomRadius;
  final VoidCallback? onTap;
  final TextInputType? keyboardType;
  final bool? areaCode;
  final bool? hidePass;
  final FocusNode? focusNode;
  final Function(String)? onChanged;
  const InputCustom({
    Key? key,
    this.controller,
    this.colorInput,
    this.labelText,
    this.topRadius,
    this.bottomRadius,
    this.onTap,
    this.keyboardType,
    this.areaCode,
    this.hidePass,
    this.focusNode,
    this.onChanged,
    this.maxLines,
    this.maxLength,
    this.colorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Material(
        color: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.w),
          child: Column(
            children: [
              Container(height: 10.h, color: colorInput ?? Colors.transparent),
              TextField(
                maxLength: maxLength,
                maxLines: maxLines ?? 1,
                onChanged: onChanged,
                focusNode: focusNode,
                obscureText: hidePass == true ? true: false,
                onTap: onTap,
                controller: controller,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.w),
                  filled: true,
                  fillColor: colorInput ?? Colors.transparent,
                  labelText: labelText,
                  labelStyle: TextStyle(color: ThemeColor.whiteColor.withOpacity(0.5)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(bottomRadius ?? 0),
                      bottomLeft: Radius.circular(bottomRadius ?? 0),
                      topLeft: Radius.circular(topRadius ?? 0),
                      topRight: Radius.circular(topRadius ?? 0),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(bottomRadius ?? 0),
                      bottomLeft: Radius.circular(bottomRadius ?? 0),
                      topLeft: Radius.circular(topRadius ?? 0),
                      topRight: Radius.circular(topRadius ?? 0),
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(bottomRadius ?? 0),
                      bottomLeft: Radius.circular(bottomRadius ?? 0),
                      topLeft: Radius.circular(topRadius ?? 0),
                      topRight: Radius.circular(topRadius ?? 0),
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(bottomRadius ?? 0),
                      bottomLeft: Radius.circular(bottomRadius ?? 0),
                      topLeft: Radius.circular(topRadius ?? 0),
                      topRight: Radius.circular(topRadius ?? 0),
                    ),
                  ),
                ),
                style: TextStyles.defaultStyle.setColor(colorText ?? themeNotifier.systemText),
                keyboardType: keyboardType,
                // textInputAction: TextInputAction.done,
                cursorColor: ThemeColor.pinkColor,
              )
            ],
          ),
        )
    );
  }
}
