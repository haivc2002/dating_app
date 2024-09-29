import 'package:cached_network_image/cached_network_image.dart';
import 'package:dating/bloc/bloc_home/home_bloc.dart';
import 'package:dating/common/scale_screen.dart';
import 'package:dating/common/textstyles.dart';
import 'package:dating/model/model_request_send.dart';
import 'package:dating/service/exception.dart';
import 'package:dating/service/service_message.dart';
import 'package:dating/theme/theme_color.dart';
import 'package:dating/theme/theme_image.dart';
import 'package:dating/tool_widget_custom/button_widget_custom.dart';
import 'package:dating/tool_widget_custom/wait.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../argument_model/argument_match.dart';
import '../../model/model_send_message_success.dart';

class MatchPopupScreen extends StatefulWidget {
  static const String routeName = "/matchPopupScreen";
  const MatchPopupScreen({super.key});

  @override
  State<MatchPopupScreen> createState() => _MatchPopupScreenState();
}

class _MatchPopupScreenState extends State<MatchPopupScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _color1;
  late Animation<Color?> _color2;

  bool _isSecondAvatarVisible = false;
  TextEditingController textController = TextEditingController();
  ServiceMessage serviceMessage = ServiceMessage();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _color1 = ColorTween(
      begin: ThemeColor.pinkFadeColor.withOpacity(0.2),
      end: Colors.purple,
    ).animate(_controller);

    _color2 = ColorTween(
      begin: ThemeColor.pinkColor,
      end: ThemeColor.blackNotAbsolute.withOpacity(0.3),
    ).animate(_controller);

    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) setState(() => _isSecondAvatarVisible = true);
    });

    textController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    _controller.stop();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as ArgumentMatch;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            height: heightScreen(context),
            width: widthScreen(context),
            // decoration: BoxDecoration(
            //   gradient: LinearGradient(
            //     begin: Alignment.topLeft,
            //     end: Alignment.bottomRight,
            //     colors: [_color1.value!, _color2.value!],
            //   ),
            // ),

            decoration: BoxDecoration(
              gradient: _color1.value != null && _color2.value != null
                  ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [_color1.value!, _color2.value!],
              ) : null,
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned.fill(
                  child: _background(args.image),
                ),
                _boxMessage(args.idUser),
              ],
            ),
          );
        },
      ),
    );
  }

  _background(String imageUrl) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
              return _circleAvatar(0, "${state.info?.listImage?[0].image}");
            }),
            if (_isSecondAvatarVisible) AnimatedContainer(
              curve: Curves.bounceInOut,
              duration: const Duration(milliseconds: 300),
              width: _isSecondAvatarVisible ? 130.w : 0,
              // child: _circleAvatar(1, "https://haycafe.vn/wp-content/uploads/2022/10/Hinh-anh-gai-xinh-Viet-Nam-dep-400x600.jpg"),
              child: _circleAvatar(1, imageUrl),
            ),
          ],
        ),
        TweenAnimationBuilder(
            tween: Tween<double>(end: 1.0, begin: 0.0),
            duration: const Duration(milliseconds: 700),
            curve: Curves.fastEaseInToSlowEaseOut,
            builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: TweenAnimationBuilder(
                tween: Tween<double>(end: 1.0, begin: 20.0),
                duration: const Duration(milliseconds: 700),
                curve: Curves.fastEaseInToSlowEaseOut,
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: Align(
                      heightFactor: 0.2,
                      child: Image.asset(ThemeImage.matchText, width: widthScreen(context)*0.8)
                    ),
                  );
                }
              ),
            );
          }
        ),
        SizedBox(height: heightScreen(context)/2)
      ],
    );
  }

  _boxMessage(int receiver) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          right: 20.w,
          left: 20.w,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Material(
              color: ThemeColor.whiteColor,
              borderRadius: BorderRadius.circular(10.w),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: TextField(
                  controller: textController,
                  decoration: InputDecoration(
                    hintText: "send the first message to them",
                    hintStyle: TextStyles.defaultStyle.setColor(ThemeColor.greyFadeColor).bold,
                    border: InputBorder.none,
                    suffixIcon: GestureDetector(
                      onTap: ()=> sendFirsMessage(receiver),
                      child: textController.text.isNotEmpty ? Material(
                        color: ThemeColor.whiteColor,
                        child: Padding(
                          padding: EdgeInsets.all(8.w),
                          child: const Icon(Icons.send),
                        )
                      ) : const SizedBox(),
                    )
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.w),
            IntrinsicWidth(
              child: ButtonWidgetCustom(
                textButton: 'No need',
                color: ThemeColor.blackColor,
                radius: 10,
                padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 20.w),
                styleText: TextStyles.defaultStyle.setColor(ThemeColor.whiteColor).bold,
                onTap: () => Navigator.pop(context),
              ),
            ),
            SizedBox(height: 30.w)
          ],
        ),
      ),
    );
  }

  Widget _circleAvatar(int index, String image) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 1500),
      curve: Curves.elasticOut,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(index == 0 ? 10 : -10, 0),
          child: Transform.scale(
            scale: value,
            child: Container(
              width: 130.w,
              height: 130.w,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: ThemeColor.blackColor.withOpacity(0.5),
                    offset: const Offset(0, 3),
                    blurRadius: 5
                  )
                ],
                border: Border.all(width: 5, color: ThemeColor.whiteColor),
                shape: BoxShape.circle
              ),
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: image,
                  progressIndicatorBuilder: (context, url, progress) => const Wait(),
                  errorWidget: (context, url, error) => const Icon(Icons.error, color: ThemeColor.redColor),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      }
    );
  }

  void sendFirsMessage(int receiver) async {
    int idUser = int.parse(context.read<HomeBloc>().state.info?.idUser);
    ModelRequestSend request = ModelRequestSend(
      content: textController.text,
      idUser: idUser,
      receiver: receiver
    );
    final response = await serviceMessage.send(request);
    if(response is Success<ModelSendMessageSuccess, Exception>) {
      if (response.value.result == "Success") {
        if (mounted) Navigator.pop(context);
      }
    }
  }
}