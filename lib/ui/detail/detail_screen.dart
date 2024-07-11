
import 'package:dating/common/scale_screen.dart';
import 'package:dating/common/textstyles.dart';
import 'package:dating/theme/theme_notifier.dart';
import 'package:dating/tool_widget_custom/appbar_custom.dart';
import 'package:dating/tool_widget_custom/item_card.dart';
import 'package:flutter/material.dart';
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
    final int keyHero = ModalRoute.of(context)!.settings.arguments as int;
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Scaffold(
      backgroundColor: themeNotifier.systemTheme,
      body: AppBarCustom(
        title: 'Name use',
        textStyle: TextStyles.defaultStyle.appbarTitle.bold,
        bodyListWidget: [
          Hero(
            tag: 'detail$keyHero',
            child: Container(
              height: heightScreen(context)*0.6,
              width: widthScreen(context),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://scontent.fhan3-4.fna.fbcdn.net/v/t39.30808-6/410234611_1064741508008575_9077321802523100747_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeHCfgivLMyPioQvBrx-aall8mt63cjttFrya3rdyO20WivFgNlKwUS24gv0v3vvEWVGesV9NyzHaydxglh_d-Yj&_nc_ohc=USUnZA3SmWMQ7kNvgGji5-N&_nc_zt=23&_nc_ht=scontent.fhan3-4.fna&cb_e2o_trans=t&oh=00_AYDPvYkNJ3PHcUkqJhyxtHCZT1sqOq6wfCtDfsabtA4Mvg&oe=66958430'),
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
    );
  }
}
