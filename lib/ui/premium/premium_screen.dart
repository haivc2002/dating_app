import 'package:dating/common/scale_screen.dart';
import 'package:dating/common/textstyles.dart';
import 'package:dating/theme/theme_notifier.dart';
import 'package:dating/tool_widget_custom/appbar_custom.dart';
import 'package:dating/tool_widget_custom/button_widget_custom.dart';
import 'package:dating/tool_widget_custom/item_parallax.dart';
import 'package:dating/tool_widget_custom/press_hold.dart';
import 'package:dating/ui/detail/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flip_card/flip_card.dart';


class PremiumScreen extends StatefulWidget {
  const PremiumScreen({Key? key}) : super(key: key);

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Scaffold(
      backgroundColor: themeNotifier.systemTheme,
      body: AppBarCustom(
        title: 'Premium',
        textStyle: TextStyles.defaultStyle.bold.appbarTitle,
        showLeading: false,
        scrollPhysics: const NeverScrollableScrollPhysics(),
        bodyListWidget: [
          FlipCard(
            fill: Fill.fillBack,
            direction: FlipDirection.VERTICAL,
            side: CardSide.FRONT,
            front: Container(
              child: ButtonWidgetCustom(textButton: 'Premium'),
            ),
            back: Container(
              child: ButtonWidgetCustom(textButton: 'Compatible'),
            ),
          ),
          SizedBox(
              height: heightScreen(context)*0.8,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Column(
                    children: [
                      ...List.generate(6, (index) {
                        return PressHold(
                          function: ()=> Navigator.pushNamed(context, DetailScreen.routeName, arguments: index),
                          child: ItemParallax(index: index)
                        );
                      }),
                      SizedBox(height: 100.w)
                    ]
                  ),
                ),
              )
            )

        ],
      )
    );
  }

}


