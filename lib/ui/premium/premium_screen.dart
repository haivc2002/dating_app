import 'dart:ui';

import 'package:dating/ui/premium/state_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../bloc/bloc_premium/premium_bloc.dart';
import '../../common/scale_screen.dart';
import '../../common/textstyles.dart';
import '../../theme/theme_color.dart';
import '../../theme/theme_image.dart';
import '../../theme/theme_notifier.dart';

class PremiumScreen extends StatelessWidget {
  const PremiumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return BlocBuilder<PremiumBloc, PremiumState>(
      builder: (context, state) {
        if(state is LoadPremiumState) {
          return StateScreen.wait(context);
        } else if (state is SuccessPremiumState) {
          if(state.resEnigmatic!.isNotEmpty) {
            return Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.w),
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.w,
                          mainAxisSpacing: 10.w,
                          childAspectRatio: 1/1.3
                      ),
                      itemCount: state.resEnigmatic?.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () async {
                              final _url = Uri.parse("https://sandbox.vnpayment.vn/tryitnow/Home/CreateOrder");
                              await launchUrl(_url);
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.w),
                              child: Stack(
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    child: ImageFiltered(
                                      imageFilter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                                      child: Image.network('${state.resEnigmatic?[index].listImage?[0].image}'),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      const Spacer(),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(10.w, 0, 30.w, 0),
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                              color: ThemeColor.whiteIos.withOpacity(0.7),
                                              borderRadius: BorderRadius.circular(100.w)
                                          ),
                                          child: SizedBox(
                                            height: 12.w,
                                            width: double.infinity,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(10.w, 6.w, 70.w, 6.w),
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                              color: ThemeColor.whiteIos.withOpacity(0.7),
                                              borderRadius: BorderRadius.circular(100.w)
                                          ),
                                          child: SizedBox(
                                            height: 9.w,
                                            width: double.infinity,
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                        );
                      }
                  ),
                )
            );
          } else {
            return Column(
              children: [
                SizedBox(
                  width: widthScreen(context)*0.9,
                  child: Image.asset(ThemeImage.cardPremium, fit: BoxFit.cover),
                ),
                SizedBox(height: 50.w),
                Text(
                    'you don\'t have anyone like you yet',
                    style: TextStyles.defaultStyle.setColor(themeNotifier.systemText)
                )
              ],
            );
          }

        } else {
          return StateScreen.error(context);
        }
      },
    );
  }
}
