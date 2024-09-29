import 'dart:ui';

import 'package:dating/controller/premium_controller.dart';
import 'package:dating/tool_widget_custom/appbar_custom.dart';
import 'package:dating/ui/premium/state_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../bloc/bloc_premium/premium_bloc.dart';
import '../../common/scale_screen.dart';
import '../../common/textstyles.dart';
import '../../theme/theme_color.dart';
import '../../theme/theme_image.dart';
import '../../theme/theme_notifier.dart';

class PremiumScreen extends StatefulWidget {
  static const String routeName = "/premiumScreen";
  const PremiumScreen({super.key});

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {

  late PremiumController controller;

  @override
  void initState() {
    super.initState();
    controller = PremiumController(context);
    controller.getEnigmatic();
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Scaffold(
      backgroundColor: themeNotifier.systemTheme,
      body: AppBarCustom(
        title: 'Premium',
        textStyle: TextStyles.defaultStyle.bold.appbarTitle,
        bodyListWidget: [
          BlocBuilder<PremiumBloc, PremiumState>(
            builder: (context, state) {
              if(state is LoadPremiumState) {
                return StateScreen.wait(context);
              } else if (state is SuccessPremiumState) {
                if((state.resEnigmatic??[]).isNotEmpty) {
                  return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.w),
                        child: GridView.builder(
                            shrinkWrap: true,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10.w,
                                mainAxisSpacing: 10.w,
                                childAspectRatio: 1/1.3
                            ),
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.resEnigmatic?.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  onTap: controller.getUrlPayment,
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
                  return _listNull(themeNotifier);
                }
              } else {
                return StateScreen.error(context);
              }
            },
          )
        ],
      ),
    );
  }

  _listNull(ThemeNotifier themeNotifier) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
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
}
