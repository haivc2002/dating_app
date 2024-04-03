import 'package:dating/theme/theme_color.dart';
import 'package:flutter/material.dart';

class InputWidgetCustom extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final double? radius;
  final Color? colorInput, borderColor;
  const InputWidgetCustom({
    Key? key,
    this.controller,
    this.labelText,
    this.radius,
    this.colorInput,
    this.borderColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
            vertical: 8, horizontal: 13),
        filled: true,
        fillColor: colorInput ?? ThemeColor.whiteColor,
        labelText: labelText,
        labelStyle: const TextStyle(
            color: Colors.grey, fontWeight: FontWeight.w400),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor ?? Colors.transparent),
          borderRadius: BorderRadius.circular(radius ?? 0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor ?? Colors.transparent),
          borderRadius: BorderRadius.circular(radius ?? 0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 0),
        ),
      ),
      style: const TextStyle(color: Colors.black),
      cursorColor: ThemeColor.pinkColor,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      onChanged: (text) {},
    );
  }
}
