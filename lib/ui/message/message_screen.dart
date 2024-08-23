import 'package:dating/bloc/bloc_message/message_bloc.dart';
import 'package:dating/common/scale_screen.dart';
import 'package:dating/common/textstyles.dart';
import 'package:dating/controller/message_controller.dart';
import 'package:dating/theme/theme_image.dart';
import 'package:dating/theme/theme_notifier.dart';
import 'package:dating/tool_widget_custom/appbar_custom.dart';
import 'package:dating/tool_widget_custom/press_hold_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {

  late MessageController controller;

  @override
  void initState() {
    super.initState();
    controller = MessageController(context);
  }

  @override
  void dispose() {
    super.dispose();
    controller.realTimeMessage?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    controller.getData();
    return Scaffold(
      backgroundColor: themeNotifier.systemTheme,
      body: BlocBuilder<MessageBloc, MessageState>(
        builder: (context, state) {
          return AppBarCustom(
            title: 'Message',
            textStyle: TextStyles.defaultStyle.bold.appbarTitle,
            showLeading: false,
            bodyListWidget: _view(state),
          );
        }
      )
    );
  }

  List<Widget> _view(MessageState state) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    if(state is LoadMessageState) {
      return List.generate(15, (_) {
        return Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 15.w),
          child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
              title: Row(
                children: [
                  Shimmer.fromColors(
                    baseColor: themeNotifier.systemThemeFade,
                    highlightColor: themeNotifier.systemTheme,
                    child: SizedBox(
                      height: 15.w,
                      width: 200.w,
                      child: ColoredBox(
                        color: themeNotifier.systemTheme,
                      ),
                    ),
                  ),
                  const Spacer()
                ],
              ),
              subtitle: Shimmer.fromColors(
                baseColor: themeNotifier.systemThemeFade,
                highlightColor: themeNotifier.systemTheme,
                child: SizedBox(
                  height: 10.w,
                  child: ColoredBox(
                    color: themeNotifier.systemTheme,
                  ),
                ),
              ),
              leading: CircleAvatar(radius: 40,backgroundColor: themeNotifier.systemThemeFade)
          ),
        );
      });
    } else if (state is SuccessMessageState) {
      final count = state.response.length;
      return List.generate(count, (index) {
        return PressHoldMenu(
          onTap: ()=> controller.gotoViewChat(state, index),
          menuAction: controller.menuAction,
          onPressedList: controller.onPressedList(state, index),
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 15.w),
            child: Material(
              borderRadius: BorderRadius.circular(10.w),
              color: themeNotifier.systemTheme,
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
                title: Text('${state.response[index].info?.name}', style: TextStyles
                    .defaultStyle
                    .bold
                    .setColor(themeNotifier.systemText)
                    .setTextSize(15.sp)
                ),
                subtitle: SizedBox(
                  width: 180.w,
                  child: controller.returnContentMessage(state, index, themeNotifier),
                ),
                leading: CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                      '${state.response[index].listImage?[0].image}'
                    ),
                  ),
                trailing: controller.iconState(state, index)
              ),
            ),
          ),
        );
      });
    } else {
      return [
        _error(),
        Text('Error! Failed to load data!', style: TextStyle(color: themeNotifier.systemText))
      ];
    }
  }

  Widget _error() {
    return Padding(
      padding: EdgeInsets.only(top: 100.w, bottom: 20.w),
      child: SizedBox(
        width: widthScreen(context)*0.6,
        child: Image.asset(ThemeImage.error),
      ),
    );
  }
}
