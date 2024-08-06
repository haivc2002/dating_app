
import 'package:dating/bloc/bloc_home/home_bloc.dart';
import 'package:dating/common/scale_screen.dart';
import 'package:dating/common/textstyles.dart';
import 'package:dating/common/year_old.dart';
import 'package:dating/controller/detail_controller.dart';
import 'package:dating/controller/home_controller.dart';
import 'package:dating/theme/theme_color.dart';
import 'package:dating/theme/theme_image.dart';
import 'package:dating/theme/theme_notifier.dart';
import 'package:dating/tool_widget_custom/appbar_custom.dart';
import 'package:dating/tool_widget_custom/item_card.dart';
import 'package:dating/tool_widget_custom/number_of_photos.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  late HomeController homeController;
  late DetailController controller;

  int page = 0;
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    homeController = HomeController(context);
    controller = DetailController(context);
    pageController.addListener(() {
      setState(() {
        page = pageController.page!.round();
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    final ArgumentsDetailModel args = ModalRoute.of(context)!.settings.arguments as ArgumentsDetailModel;
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Scaffold(
      backgroundColor: themeNotifier.systemTheme,
      body: Stack(
        children: [
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if(state is SuccessApiHomeState) {
                final data = state.listNomination?.nominations?[args.idUser!];
                return AppBarCustom(
                  title: '${data?.info?.name}, ${yearOld('${data?.info?.birthday}')}',
                  textStyle: TextStyles.defaultStyle.appbarTitle.bold,
                  bodyListWidget: [
                    Stack(
                      children: [
                        Hero(
                          tag: '${args.keyHero}',
                          child: Column(
                            children: [
                              SizedBox(
                                height: heightScreen(context)*0.6,
                                width: widthScreen(context),
                                child: PageView.builder(
                                  controller: pageController,
                                  itemCount: data?.listImage?.length,
                                  itemBuilder: (context, index) {
                                    return Image.network(
                                      '${data?.listImage?[index].image}',
                                      fit: BoxFit.cover,
                                    );
                                  }
                                ),
                              ),
                            ],
                          ),
                        ),
                        NumberOfPhotos(count: data?.listImage?.length, currentPage: page),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.w),
                      child: Column(
                        children: [
                          ItemCard(
                            titleCard: 'introduce yourself',
                            iconTitle: Icon(Icons.format_quote, color: themeNotifier.systemText),
                            fontSize: 20.sp,
                            listWidget: [
                              SizedBox(
                                width: 240.w,
                                child: Text('${data?.info?.describeYourself}', 
                                  style: TextStyles.defaultStyle.setColor(themeNotifier.systemText)
                                ),
                              )
                            ],
                          ),
                          ItemCard(
                            fontSize: 20.sp,
                            titleCard: 'Information base',
                            iconTitle: Icon(CupertinoIcons.person_alt_circle_fill, color: themeNotifier.systemText),
                            listWidget: [
                              _infoBase(Icons.location_on_outlined, ' ${homeController.calculateDistance(state, args.idUser!)} away'),
                              _infoBase(Icons.school_outlined, ' ${data?.info?.academicLevel}'),
                              _infoBase(Icons.work_outline, ' ${data?.info?.word}'),
                            ],
                          ),
                          ItemCard(
                            fontSize: 20.sp,
                            titleCard: '${data?.info?.desiredState}',
                            titleColor: ThemeColor.pinkColor,
                            iconTitle: Icon(CupertinoIcons.square_stack_3d_up, color: ThemeColor.pinkColor.withOpacity(0.5)),
                          ),
                          ItemCard(
                            fontSize: 20.sp,
                            titleCard: 'Information more',
                            iconTitle: Icon(Icons.contacts_outlined, color: themeNotifier.systemText),
                            listWidget: [
                              SizedBox(height: 20.w),
                              SizedBox(
                                width: widthScreen(context)*0.77,
                                child: Wrap(
                                  direction: Axis.horizontal,
                                  runSpacing: 7.w,
                                  spacing: 7.w,
                                  children: controller.items(data!).isEmpty
                                    ? [Text('No information available', style: TextStyles.defaultStyle.setColor(themeNotifier.systemText))]
                                    : controller.items(data)
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                );
              } else {
                return Image.asset(ThemeImage.error);
              }

            }
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

  Widget _infoBase(IconData iconData, String data) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.w),
      child: Row(
        children: [
          Icon(iconData, color: themeNotifier.systemText.withOpacity(0.5)),
          SizedBox(width: 10.w),
          Text(data.isNotEmpty ? data : '', style: TextStyles.defaultStyle.setColor(themeNotifier.systemText))
        ],
      ),
    );
  }
}
