import 'package:dating/argument_model/arguments_detail_model.dart';
import 'package:dating/common/scale_screen.dart';
import 'package:dating/common/textstyles.dart';
import 'package:dating/controller/premium_controller.dart';
import 'package:dating/theme/theme_notifier.dart';
import 'package:dating/tool_widget_custom/appbar_custom.dart';
import 'package:dating/tool_widget_custom/build/extension_build.dart';
import 'package:dating/tool_widget_custom/item_parallax.dart';
import 'package:dating/tool_widget_custom/press_hold.dart';
import 'package:dating/ui/detail/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

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
        SizedBox(
            height: heightScreen(context)*0.8,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                  children: [
                    ...List.generate(6, (index) {
                      return PressHold(
                        function: ()=> Navigator.pushNamed(context, DetailScreen.routeName, arguments: ArgumentsDetailModel(keyHero: index)),
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
            return Container(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10.w)
              ),
            );
          }
        ),
      )
    );
  }
}


