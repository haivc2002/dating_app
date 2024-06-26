import 'dart:ffi';

import 'package:dating/common/scale_screen.dart';
import 'package:dating/common/textstyles.dart';
import 'package:dating/theme/theme_image.dart';
import 'package:dating/theme/theme_notifier.dart';
import 'package:dating/tool_widget_custom/appbar_custom.dart';
import 'package:dating/tool_widget_custom/item_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  static const String routeName = 'detailScreen';
  const DetailScreen({Key? key}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Scaffold(
      backgroundColor: themeNotifier.systemTheme,
      body: AppBarCustom(
        title: 'Name use',
        textStyle: TextStyles.defaultStyle.appbarTitle.bold,
        bodyListWidget: [
          Hero(
            tag: 'detail',
            child: Container(
              height: heightScreen(context)*0.6,
              color: Colors.red,
              width: widthScreen(context),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.w),
            child: Column(
              children: [
                ItemCard(
                  titleCard: 'I need to find',
                ),
                ItemCard(),
                ItemCard(),
                ItemCard(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
