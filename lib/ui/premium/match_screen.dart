import 'package:dating/bloc/bloc_premium/premium_bloc.dart';
import 'package:dating/common/scale_screen.dart';
import 'package:dating/common/textstyles.dart';
import 'package:dating/controller/premium_controller.dart';
import 'package:dating/theme/theme_color.dart';
import 'package:dating/theme/theme_notifier.dart';
import 'package:dating/tool_widget_custom/appbar_custom.dart';
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
    controller.getDataMatch();
  }

  @override
  Widget build(BuildContext context) {
    return AppBarCustom(
      title: 'Match',
      textStyle: TextStyles.defaultStyle.bold.appbarTitle,
      showLeading: false,
      scrollPhysics: const NeverScrollableScrollPhysics(),
      bodyListWidget: [
        _build(),
      ],
    );
  }

  Widget _build() {
    return Column(
      children: [
        GestureDetector(
          onTap: ()=> Navigator.pushNamed(context, PremiumScreen.routeName),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 20.w),
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
            ),
          ),
        ),
        BlocBuilder<PremiumBloc, PremiumState>(
            builder: (context, state) {
              if(state is LoadPremiumState) {
                return StateScreen.wait(context);
              } else if(state is SuccessPremiumState) {
                return _cardInfo(state);
              } else {
                return StateScreen.error(context);
              }
            }
        )
      ],
    );
  }

  Widget _cardInfo(SuccessPremiumState state) {
    final listResMatches = state.resMatches ?? [];
    return SizedBox(
        height: heightScreen(context)*0.8,
        child: RefreshIndicator(
          onRefresh: () async => await controller.getDataMatch(),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
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
                          return Stack(
                            fit: StackFit.expand,
                            children: [
                              ItemParallax(
                                index: index,
                                height: itemHeight,
                                width: itemWidth,
                                subTitle: state.resMatches?[index].info?.desiredState,
                                title: state.resMatches?[index].info?.name,
                                image: state.resMatches?[index].listImage?[0].image,
                                itemNew: state.resMatches?[index].newState == 1 ? true : false,
                              ),
                              _dotNew(state.resMatches?[index].newState ?? 0)
                            ],
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
        ),
    );
  }

  _dotNew(int newState) {
    if(newState == 1) {
      return Positioned(
          right: 0,
          child: Align(
            widthFactor: 0.5,
            heightFactor: 1.5,
            child: ClipOval(
              child: ColoredBox(
                color: ThemeColor.deepRedColor,
                child: SizedBox(height: 15.w, width: 15.w),
              ),
            ),
          )
      );
    } else {
      return const SizedBox.shrink();
    }
  }


}



