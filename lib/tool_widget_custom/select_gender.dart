import 'package:dating/bloc/bloc_auth/register_bloc.dart';
import 'package:dating/common/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/theme_color.dart';
import '../theme/theme_image.dart';

class SelectGender extends StatefulWidget {
  const SelectGender({super.key});

  @override
  State<SelectGender> createState() => _SelectGenderState();
}

class _SelectGenderState extends State<SelectGender> {

  double isWidth = 150.w;
  int isSelect = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: ThemeColor.themeLightSystem,
          borderRadius: BorderRadius.circular(10.w)
      ),
      child: Column(
        children: [
          BlocBuilder<RegisterBloc, RegisterState>(
            builder: (context, state) {
              return SizedBox(
                height: 50.w,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    children: [
                      Text('Your gender:', style: TextStyles.defaultStyle),
                      const Spacer(),
                      Text(valueGender(state), style: TextStyles
                          .defaultStyle
                          .bold
                          .setColor(colorValueGender(state)))
                    ],
                  ),
                ),
              );
            }
          ),
          BlocBuilder<RegisterBloc, RegisterState>(
            builder: (context, state) {
              return Row(
                children: [
                  const Spacer(),
                  AnimatedScale(
                    duration: const Duration(milliseconds: 200),
                    scale: state.indexItemGender == 1 ? 1 : 0.9,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.w),
                      child: GestureDetector(
                        onTap: ()=> context.read<RegisterBloc>().add(RegisterEvent(indexItemGender: 1, genderValue: 'female')),
                        child: AnimatedContainer(
                          curve: Curves.fastEaseInToSlowEaseOut,
                          duration: const Duration(milliseconds: 300),
                          height: 200.w,
                          width: widthExtension(1, state),
                          child: Image.asset(ThemeImage.genderFeMale, fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  AnimatedScale(
                    duration: const Duration(milliseconds: 200),
                    scale: state.indexItemGender == 2 ? 1 : 0.9,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.w),
                      child: GestureDetector(
                        onTap: ()=> context.read<RegisterBloc>().add(RegisterEvent(indexItemGender: 2, genderValue: 'male')),
                        child: AnimatedContainer(
                          curve: Curves.fastEaseInToSlowEaseOut,
                          duration: const Duration(milliseconds: 300),
                          height: 200.w,
                          width: widthExtension(2, state),
                          child: Image.asset(ThemeImage.genderMale, fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              );
            }
          ),
          SizedBox(height: 20.w)
        ],
      ),
    );
  }

  double widthExtension(int value, RegisterState state) {
    double result = 0;
    if(state.indexItemGender == null || state.indexItemGender == 0) {
      result = 150.w;
    } else if(state.indexItemGender == value) {
      result = 200.w;
    } else {
      result = 100.w;
    }
    return result;
  }

  String valueGender(RegisterState state) {
    if(state.indexItemGender == 1) {
      return 'FeMale';
    } else if(state.indexItemGender == 2) {
      return 'Male';
    } else {
      return 'Empty';
    }
  }

  Color colorValueGender(RegisterState state) {
    if(state.indexItemGender == 1) {
      return ThemeColor.pinkColor;
    } else if(state.indexItemGender == 2) {
      return ThemeColor.blueColor;
    } else {
      return ThemeColor.blackColor;
    }
  }
}


