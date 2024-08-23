import 'dart:ui';

import 'package:dating/bloc/bloc_message/detail_message_bloc.dart';
import 'package:dating/common/global.dart';
import 'package:dating/common/textstyles.dart';
import 'package:dating/controller/message_controller.dart';
import 'package:dating/theme/theme_color.dart';
import 'package:dating/theme/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../argument_model/arguments_detail_model.dart';

class ViewChatScreen extends StatefulWidget {
  static const String routeName = 'viewChatScreen';
  const ViewChatScreen({super.key});

  @override
  State<ViewChatScreen> createState() => _ViewChatScreenState();
}

class _ViewChatScreenState extends State<ViewChatScreen> {

  late ArgumentsDetailModel args;
  late MessageController controller;
  String idUser = Global.getInt('idUser').toString();

  bool isSend = false;
  String sendText = '';

  @override
  void initState() {
    super.initState();
    controller = MessageController(context);
  }

  @override
  void dispose() {
    super.dispose();
    controller.stopReconnecting();
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    args = ModalRoute.of(context)!.settings.arguments as ArgumentsDetailModel;
    controller.connect(idUser, args.idUser!);
    controller.continuous(idUser, args.idUser!);
    return Scaffold(
      backgroundColor: themeNotifier.systemTheme,
      body: Stack(
        children: [
          BlocBuilder<DetailMessageBloc, DetailMessageState>(
            builder: (context, state) {
              return Column(
                children: [
                  _contentMessage(state),
                  _messageBox(),
                ],
              );
            }
          ),
          _chatBar(),
        ],
      ),
    );
  }

  Widget _messageBox() {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          Flexible(
            fit: FlexFit.loose,
            child: TextField(
              controller: controller.content,
              minLines: 1,
              maxLines: 3,
              cursorColor: ThemeColor.pinkColor,
              style: TextStyles.defaultStyle.setColor(themeNotifier.systemText),
              decoration: InputDecoration(
                hintText: 'Enter message...',
                hintStyle: TextStyles.defaultStyle.setColor(ThemeColor.greyColor.withOpacity(0.7)),
                contentPadding: EdgeInsets.all(10.w),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
              onPressed: ()=> controller.sendMessage(int.parse(idUser), args.idUser!),
              icon: const Icon(Icons.send, color: ThemeColor.pinkColor)
          )
        ],
      ),
    );
  }

  Widget _chatBar() {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return SizedBox(
      height: 100.w,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 20, sigmaX: 20),
          child: Column(
            children: [
              const Spacer(),
              SizedBox(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: ()=> Navigator.pop(context),
                          icon: Icon(Icons.arrow_back_ios_new, color: themeNotifier.systemText)
                      ),
                      SizedBox(width: 10.w),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100.w),
                        child: SizedBox(
                          height: 35.w,
                          width: 35.w,
                          child: Image.network('${args.listImage?[0].image}', fit:  BoxFit.cover),
                        ),
                      ),
                      SizedBox(width: 20.w),
                      Text('${args.info?.name}', style: TextStyles.defaultStyle.bold.setColor(themeNotifier.systemText).setTextSize(18.sp))
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.w)
            ],
          ),
        ),
      ),
    );
  }

  Widget _contentMessage(DetailMessageState state) {
    if((state.response??[]).isNotEmpty) controller.checkMessage(int.parse(idUser), state);
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: ListView.builder(
          reverse: true,
          itemCount: (state.response ?? []).length + 1,
          itemBuilder: (context, index) {
            if (index == (state.response ?? []).length) {
              return SizedBox(height: 130.w);
            }
            final actualIndex = index;
            if (state.response?[actualIndex].idUser == Global.getInt('idUser')) {
              return _sender(state, actualIndex);
            } else {
              return _receiver(state, actualIndex);
            }
          },
        ),
      ),
    );
  }

  Widget _sender(DetailMessageState state, int index) {
    return Row(
      children: [
        const Spacer(),
        Container(
          decoration: BoxDecoration(
            color: ThemeColor.pinkColor,
            borderRadius: BorderRadius.circular(15.w)
          ),
          constraints: BoxConstraints(
            maxWidth: 250.w
          ),
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 6.w),
          margin: EdgeInsets.only(bottom: 2.w),
          child: Text('${state.response?[index].content}', style: TextStyles.defaultStyle.whiteText),
        ),
      ],
    );
  }

  Widget _receiver(DetailMessageState state, int index) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    bool showAvt = state.response?[index+1].idUser != state.response?[index].idUser;
    return Row(
      children: [
        showAvt ? ClipRRect(
          borderRadius: BorderRadius.circular(100.w),
          child: SizedBox(
            height: 25.w,
            width: 25.w,
            child: Image.network('${args.listImage?[0].image}', fit: BoxFit.cover),
          ),
        ) : SizedBox(height: 25.w, width: 25.w),
        SizedBox(width: 10.w),
        Container(
          decoration: BoxDecoration(
            color: themeNotifier.systemThemeFade,
            borderRadius: BorderRadius.circular(15.w),
            border: Border.all(color: themeNotifier.systemText.withOpacity(0.1))
          ),
          constraints: BoxConstraints(maxWidth: 250.w),
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 6.w),
          margin: EdgeInsets.only(bottom: 2.w),
          child: Text('${state.response?[index].content}', style: TextStyles.defaultStyle.setColor(themeNotifier.systemText)),
        ),
      ],
    );
  }

}
