import 'package:dating/common/scale_screen.dart';
import 'package:dating/common/textstyles.dart';
import 'package:dating/theme/theme_notifier.dart';
import 'package:dating/tool_widget_custom/appbar_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../theme/theme_color.dart';

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
        bodyListWidget: [
          Stack(
            children: [
              SizedBox(
                height: 50.w,
                child: Row(
                  children: [
                    Expanded(child: InkWell(
                      onTap: () {},
                      child: Center(child: Text('test')),
                    )),
                    Expanded(child: InkWell(
                      onTap: () {},
                      child: Center(child: Text('test')),
                    ))
                  ],
                ),
              ),

            ],
          )
        ],
      )
    );
  }

}



