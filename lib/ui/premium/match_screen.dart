import 'package:dating/bloc/bloc_premium/premium_bloc.dart';
import 'package:dating/common/scale_screen.dart';
import 'package:dating/common/textstyles.dart';
import 'package:dating/controller/premium_controller.dart';
import 'package:dating/theme/theme_notifier.dart';
import 'package:dating/tool_widget_custom/appbar_custom.dart';
import 'package:dating/tool_widget_custom/build/extension_build.dart';
import 'package:dating/tool_widget_custom/item_parallax.dart';
import 'package:dating/tool_widget_custom/press_hold.dart';
import 'package:dating/ui/premium/premium_screen.dart';
import 'package:dating/ui/premium/state_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../common/extension/gradient.dart';


class MatchScreen extends StatefulWidget {
  const MatchScreen({Key? key}) : super(key: key);

  @override
  State<MatchScreen> createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> with TickerProviderStateMixin{

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
      extension: _extension(),
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
              return StateScreen.wait(context);
            } else if(state is SuccessPremiumState) {
              return _cardInfo(state, function);
            } else {
              return StateScreen.error(context);
            }
          }
        )
      ],
    );
  }

  Widget _extension() {
    return const PremiumScreen();
  }

  Widget _cardInfo(SuccessPremiumState state, PopupController function) {
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
                  child: PressHold(
                    onTap: ()=> controller.getGotoViewChat(state, index),
                    function: ()=> controller.gotoDetail(state, index),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double itemWidth = constraints.maxWidth;
                        double itemHeight = constraints.maxHeight;
                        return ItemParallax(
                          index: index,
                          height: itemHeight,
                          width: itemWidth,
                          subTitle: state.resMatches?[index].info?.desiredState,
                          title: state.resMatches?[index].info?.name,
                          image: state.resMatches?[index].listImage?[0].image,
                          itemNew: state.resMatches?[index].newState == 1 ? true : false,
                        );
                      }
                    ),
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



