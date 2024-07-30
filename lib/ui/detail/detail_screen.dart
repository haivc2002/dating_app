
import 'package:dating/common/scale_screen.dart';
import 'package:dating/common/textstyles.dart';
import 'package:dating/theme/theme_color.dart';
import 'package:dating/theme/theme_notifier.dart';
import 'package:dating/tool_widget_custom/appbar_custom.dart';
import 'package:dating/tool_widget_custom/item_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:swipable_stack/swipable_stack.dart';

import '../../argument_model/arguments_detail_model.dart';

class DetailScreen extends StatefulWidget {
  static const String routeName = 'detailScreen';
  const DetailScreen({Key? key}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    final ArgumentsDetailModel args = ModalRoute.of(context)!.settings.arguments as ArgumentsDetailModel;
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Scaffold(
      backgroundColor: themeNotifier.systemTheme,
      body: Stack(
        children: [
          AppBarCustom(
            title: 'Name use',
            textStyle: TextStyles.defaultStyle.appbarTitle.bold,
            bodyListWidget: [
              Hero(
                tag: '${args.keyHero}',
                child: Container(
                  height: heightScreen(context)*0.6,
                  width: widthScreen(context),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage('https://scontent.fhan3-2.fna.fbcdn.net/v/t39.30808-6/410901502_1064741344675258_6524863206527149438_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeHTTPgyIimQp_GRwRVGIFfaGPBdOLhPQKcY8F04uE9ApwhVlMk9aU_NaGYsVGYGpfHfl9IGLb83TmePogL4XvBY&_nc_ohc=d8qYPy0u4bQQ7kNvgFQaJV5&_nc_ht=scontent.fhan3-2.fna&cb_e2o_trans=t&oh=00_AYA2usHbWG9iPkByAZgDtl9IL7YaaFmhiD9r0wLukYTxYw&oe=669B98E7'),
                      fit: BoxFit.cover
                    )
                  ),
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
          Positioned(
            bottom: 0,
            child: _btnBefore(args)
          )
        ],
      ),
    );
  }

  Widget _btnBefore(ArgumentsDetailModel args) {
    return SizedBox(
      height: 150.w,
      width: widthScreen(context),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 50.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _btnLeftOrRight(
              color: ThemeColor.themeLightSystem,
              onTap: ()=> args.controller?.next(swipeDirection: SwipeDirection.left),
              icon: CupertinoIcons.clear
            ),
            _btnLeftOrRight(
              border: false,
              color: ThemeColor.pinkColor,
              onTap: ()=> args.controller?.next(swipeDirection: SwipeDirection.right),
              icon: Icons.favorite
            ),
          ],
        ),
      ),
    );
  }

  Widget _btnLeftOrRight({required Color color, bool? border, required Function() onTap, required IconData icon}) {
    return Expanded(
      child: GestureDetector(
        onTap: () async {
          Navigator.pop(context);
          border??true ? null : HapticFeedback.vibrate();
          await Future.delayed(const Duration(milliseconds: 300));
          onTap();
        },
        child: Container(
          height: 70.w,
          width: 70.w,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: border??true ? Border.all(width: 2.w, color: ThemeColor.blackColor.withOpacity(0.4)) : null,
            boxShadow: [
              BoxShadow(
                color: ThemeColor.blackColor.withOpacity(0.4),
                offset: Offset(0, 5.w),
                blurRadius: 15,
                spreadRadius: 0
              )
            ]
          ),
          child: Center(
            child: Icon(icon, size: 40.sp, color: border??true ? ThemeColor.blackColor : ThemeColor.whiteColor),
          ),
        ),
      ),
    );
  }
}
