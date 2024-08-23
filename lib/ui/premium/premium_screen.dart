import 'dart:ui';
import 'package:dating/bloc/bloc_premium/premium_bloc.dart';
import 'package:dating/common/scale_screen.dart';
import 'package:dating/common/textstyles.dart';
import 'package:dating/controller/premium_controller.dart';
import 'package:dating/theme/theme_color.dart';
import 'package:dating/theme/theme_image.dart';
import 'package:dating/theme/theme_notifier.dart';
import 'package:dating/tool_widget_custom/appbar_custom.dart';
import 'package:dating/tool_widget_custom/build/extension_build.dart';
import 'package:dating/tool_widget_custom/item_parallax.dart';
import 'package:dating/tool_widget_custom/press_hold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/extension/gradient.dart';


class PremiumScreen extends StatefulWidget {
  const PremiumScreen({Key? key}) : super(key: key);

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {

  late PremiumController controller;
  late String imagePremium;
  @override
  void initState() {
    super.initState();
    controller = PremiumController(context);
    controller.getMatches();
    controller.getEnigmatic();
    imagePremium = ThemeImage.cardPremium;
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return ExtensionBuild(
      builder: (function) {
        return Scaffold(
          backgroundColor: themeNotifier.systemTheme,
          body: AppBarCustom(
            title: 'Premium',
            textStyle: TextStyles.defaultStyle.bold.appbarTitle,
            showLeading: false,
            scrollPhysics: const NeverScrollableScrollPhysics(),
            bodyListWidget: [
              _build(function),
            ],
          )
        );
      },
      extension: _extension(),
    );
  }

  Widget _build(PopupController function) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 20.w),
          child: GestureDetector(
            onTap: function.open,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: GradientColor.gradientPremium,
                borderRadius: BorderRadius.circular(100.w)
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.w),
                child: Row(
                  children: [
                    const Spacer(),
                    Text('Someone favourite you', style: TextStyles.defaultStyle.bold),
                    const Spacer(),
                  ],
                ),
              ),
            )
          ),
        ),
        BlocBuilder<PremiumBloc, PremiumState>(
          builder: (context, state) {
            if(state is LoadPremiumState) {
              return _wait();
            } else if(state is SuccessPremiumState) {
              return _cardInfo(state);
            } else {
              return _error();
            }
          }
        )
      ],
    );
  }

  Widget _extension() {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return BlocBuilder<PremiumBloc, PremiumState>(
      builder: (context, state) {
        if(state is LoadPremiumState) {
          return _wait();
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
                  child: Image.asset(imagePremium, fit: BoxFit.cover),
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
          return _error();
        }
      },
    );
  }

  Widget _wait() {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: SizedBox(
        height: heightScreen(context)*0.8,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.w,
            childAspectRatio: 0.76,
            mainAxisSpacing: 6.w,
          ),
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 5.w),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.w),
                child: ColoredBox(
                  color: themeNotifier.systemThemeFade,
                  child: Column(
                    children: [
                      const Spacer(),
                      SizedBox(
                        height: 60.w,
                        width: double.infinity,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: GradientColor.gradientBlackFade
                          ),
                          child: Shimmer.fromColors(
                            baseColor: themeNotifier.systemThemeFade,
                            highlightColor: themeNotifier.systemTheme,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(10.w, 0, 30.w, 0),
                                  child: SizedBox(
                                    height: 13.w,
                                    width: double.infinity,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100.w),
                                      child: const ColoredBox(color: ThemeColor.themeDarkSystem),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 7.w),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(10.w, 0, 70.w, 0),
                                  child: SizedBox(
                                    height: 10.w,
                                    width: double.infinity,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100.w),
                                      child: const ColoredBox(color: ThemeColor.themeDarkSystem),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        )
      ),
    );
  }

  Widget _error() {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return SizedBox(
      height: heightScreen(context)*0.6,
      child: SizedBox(
        width: widthScreen(context)*0.7,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(ThemeImage.error),
              SizedBox(height: 20.w),
              Text('Error! Failed to load data!', style: TextStyles.defaultStyle.setColor(themeNotifier.systemText))
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardInfo(SuccessPremiumState state) {
    final listResMatches = state.resMatches ?? [];
    return SizedBox(
        height: heightScreen(context)*0.8,
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.w,
            childAspectRatio: 0.8
          ),
          itemCount: listResMatches.length%2==0 ? listResMatches.length+1 : listResMatches.length+2,
          itemBuilder: (context, index) {
              if(index <= listResMatches.length - 1) {
                return Padding(
                  padding: EdgeInsets.only(
                    left: index % 2 != 0 ? 0 : 15.w,
                    right: index % 2 == 0 ? 0 : 15.w,
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      double itemWidth = constraints.maxWidth;
                      double itemHeight = constraints.maxHeight;
                      return PressHold(
                        onTap: ()=> print(state.resMatches?[index].idUser),
                        function: ()=> controller.gotoDetail(state, index),
                        child: ItemParallax(
                          index: index,
                          height: itemHeight,
                          width: itemWidth,
                          subTitle: state.resMatches?[index].info?.desiredState,
                          title: state.resMatches?[index].info?.name,
                          image: state.resMatches?[index].listImage?[0].image,
                          itemNew: state.resMatches?[index].newState == 1 ? true : false,
                        )
                      );
                    }
                  ),
                );
              } else {
                return const SizedBox();
              }
            }
        ),
    );
  }

}



