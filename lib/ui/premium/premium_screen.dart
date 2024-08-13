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
  @override
  void initState() {
    super.initState();
    controller = PremiumController(context);
    controller.getData();
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
        GestureDetector(
          onTap: function.open,
          child: Container(
            decoration: BoxDecoration(
              gradient: GradientColor.gradientPremium,
              borderRadius: BorderRadius.circular(100.w)
            ),
            padding: EdgeInsets.symmetric(vertical: 10.w),
            margin: EdgeInsets.symmetric(vertical: 10.w, horizontal: 20.w),
            child: Center(
              child: Text('Someone favourite you', style: TextStyles.defaultStyle.bold),
            ),
          )
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
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () async {
                final Uri url = Uri.parse('https://sandbox.vnpayment.vn/tryitnow/Home/CreateOrder');
                if (!await launchUrl(url)) {
                  throw Exception('Could not launch $url');
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10.w)
                ),
              ),
            );
          }
        ),
      )
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
                        height: 50.w,
                        width: double.infinity,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: GradientColor.gradientBlackFade
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w,  vertical: 15.w),
                            child: Shimmer.fromColors(
                              baseColor: themeNotifier.systemThemeFade,
                              highlightColor: themeNotifier.systemTheme,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100.w),
                                child: const ColoredBox(color: ThemeColor.themeDarkSystem),
                              ),
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
    return SizedBox(
        height: heightScreen(context)*0.8,
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.w,
            childAspectRatio: 0.8
          ),
          itemCount: state.response.length%2==0 ? state.response.length+1 : state.response.length+2,
          itemBuilder: (context, index) {
              if(index <= state.response.length - 1) {
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
                        function: ()=> controller.gotoDetail(state, index),
                        child: ItemParallax(
                          index: index,
                          height: itemHeight,
                          width: itemWidth,
                          subTitle: state.response[index].info?.desiredState,
                          title: state.response[index].info?.name,
                          image: state.response[index].listImage?[0].image,
                          itemNew: state.response[index].newState == 1 ? true : false,
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


