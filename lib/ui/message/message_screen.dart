import 'package:dating/argument_model/arguments_detail_model.dart';
import 'package:dating/common/textstyles.dart';
import 'package:dating/theme/theme_notifier.dart';
import 'package:dating/tool_widget_custom/appbar_custom.dart';
import 'package:dating/tool_widget_custom/press_hold_menu.dart';
import 'package:dating/ui/detail/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Scaffold(
      backgroundColor: themeNotifier.systemTheme,
      body: AppBarCustom(
        title: 'Message',
        textStyle: TextStyles.defaultStyle.bold.appbarTitle,
        showLeading: false,
        bodyListWidget: [
          SizedBox(height: 50.w),
          ...List.generate(15, (index) {
            return PressHoldMenu(
              menuAction: const [
                'Chat',
                'Information',
                'Delete',
              ],
              onPressedList: [
                ()=> print('object $index'),
                ()=> Navigator.pushNamed(context, DetailScreen.routeName, arguments: ArgumentsDetailModel(keyHero: index)),
                ()=> print('object'),
              ],
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 15.w),
                child: Material(
                  borderRadius: BorderRadius.circular(10.w),
                  color: themeNotifier.systemTheme,
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
                    title: Text('ằifhwg', style: TextStyles
                      .defaultStyle
                      .bold
                      .setColor(themeNotifier.systemText)
                      .setTextSize(15.sp)
                    ),
                    subtitle: Text('athgawihgfw', style: TextStyles
                      .defaultStyle
                      .setColor(themeNotifier.systemText.withOpacity(0.7))
                    ),
                    leading: const CircleAvatar(radius: 40,)
                  ),
                ),
              ),
            );
          }),
        ],
      )
    );
  }
}
