import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bloc/bloc_all_tap/all_tap_bloc.dart';
import '../../controller/all_tap_controller.dart';
import '../../theme/theme_color.dart';
import '../../theme/theme_icon.dart';

class BottomBar extends StatelessWidget {
  final AllTapController controller;
  const BottomBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: bottom(controller),
    );
  }

  Widget bottom(AllTapController controller) {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: ThemeColor.blackColor.withOpacity(0.9),
          borderRadius: BorderRadius.circular(10.w),
          border: Border.all(
              color: ThemeColor.whiteColor.withOpacity(0.2),
              width: 1.5
          )
      ),
      child: SizedBox(
        height: 55.w,
        child: BlocBuilder<AllTapBloc, AllTapState>(
            builder: (context, state) {
              return Row(
                children: [
                  buttonBottom(state, DecoratedBox(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: state.selectedIndex != 0 ? Colors.transparent : Colors.red,
                              blurRadius: 25.w
                          )
                        ]
                    ),
                    child: Icon(
                      state.selectedIndex == 0 ? Icons.favorite : Icons.favorite_border_outlined,
                      color: state.selectedIndex == 0 ? ThemeColor.redColor: ThemeColor.whiteColor,
                    ),
                  ),
                          () => controller.onItemTapped(0)
                  ),
                  buttonBottom(state, DecoratedBox(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: state.selectedIndex != 1 ? Colors.transparent : Colors.yellow,
                              blurRadius: 25.w
                          )
                        ]
                    ),
                    child: Image.asset(
                      state.selectedIndex == 1 ? ThemeIcon.starBoldIcon : ThemeIcon.starLineIcon,
                      height: 22.w,
                      color: state.selectedIndex == 1 ? null : Colors.white,
                    ),
                  ),
                          () => controller.onItemTapped(1)
                  ),
                  buttonBottom(state, DecoratedBox(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: state.selectedIndex != 2 ? Colors.transparent : Colors.blue,
                              blurRadius: 25.w
                          )
                        ]
                    ),
                    child: Image.asset(
                      state.selectedIndex == 2 ? ThemeIcon.messageBoldIcon : ThemeIcon.messageLineIcon,
                      height: 15.w,
                      color: state.selectedIndex == 2 ? null : Colors.white,
                    ),
                  ),
                          () => controller.onItemTapped(2)
                  ),
                  buttonBottom(state, DecoratedBox(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: state.selectedIndex != 3 ? Colors.transparent : ThemeColor.pinkColor,
                              blurRadius: 25.w
                          )
                        ]
                    ),
                    child: Icon(
                      state.selectedIndex == 3 ? Icons.person : Icons.person_outline,
                      color: state.selectedIndex == 3 ? ThemeColor.pinkColor : ThemeColor.whiteColor,
                    ),
                  ),
                          () => controller.onItemTapped(3)
                  ),
                ],
              );
            }
        ),
      ),
    );
  }

  Widget buttonBottom(AllTapState state, Widget child, Function() onTap) {
    return Expanded(
        child: InkWell(
          borderRadius: BorderRadius.circular(10.w),
          onTap: onTap,
          child: SizedBox(
              height: 55.w,
              child: ColoredBox(
                color: Colors.transparent,
                child: Center(
                  child: child,
                ),
              )
          ),
        )
    );
  }
}
