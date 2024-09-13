
import 'package:dating/bloc/bloc_home/home_bloc.dart';
import 'package:dating/common/extension/gradient.dart';
import 'package:dating/common/scale_screen.dart';
import 'package:dating/theme/theme_color.dart';
import 'package:dating/theme/theme_image.dart';
import 'package:dating/tool_widget_custom/appbar_custom.dart';
import 'package:dating/tool_widget_custom/button_widget_custom.dart';
import 'package:dating/tool_widget_custom/press_hold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:swipable_stack/swipable_stack.dart';

import '../../../common/textstyles.dart';
import '../../../theme/theme_notifier.dart';
import '../../common/year_old.dart';
import '../../controller/home_controller.dart';
import '../../model/model_list_nomination.dart';
import '../../tool_widget_custom/number_of_photos.dart';
import 'home_component.dart';

class HomeScreen extends StatefulWidget {
  final void Function(BuildContext) openDrawer;
  final BuildContext buildContext;
  final AnimationController animationController;
  final SwipableStackController swiController;
  const HomeScreen({
    Key? key,
    required this.openDrawer,
    required this.buildContext,
    required this.animationController,
    required this.swiController
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  late HomeController controller;
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    controller = HomeController(context);
    controller.popupSwipe();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        top: false,
        child: AppBarCustom(
          title: 'Dash Date',
          leadingIcon: GestureDetector(
            onTap: () {
              widget.openDrawer(widget.buildContext);
              setState(() {
                widget.animationController.forward();
              });
            },
            child: const ColoredBox(
              color: ThemeColor.whiteColor,
              child: Center(
                child: Icon(Icons.menu),
              ),
            ),
          ),
          scrollPhysics: const NeverScrollableScrollPhysics(),
          textStyle: TextStyles.defaultStyle.bold.setColor(ThemeColor.pinkColor).setTextSize(18.sp),
          bodyListWidget: [
            BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
              if (state.isLoading!) {
                return HomeComponent.load(context);
              } else {
                return Stack(
                  children: [
                    HomeComponent.listNominationNull(context, controller, widget.swiController.currentIndex),
                    _swiperStack(state),
                  ],
                );
              }
            })
          ],
        ),
      ),
    );
  }

  Widget _swiperStack(HomeState state) {
    final nominations = state.listNomination?.nominations ?? [];
    final length = nominations.length;
    return SizedBox(
      height: heightScreen(context) * 0.8,
      width: widthScreen(context),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Hero(
                tag: '0',
                child: SwipableStack(
                  detectableSwipeDirections: const {
                    SwipeDirection.right,
                    SwipeDirection.left,
                  },
                  controller: widget.swiController,
                  stackClipBehaviour: Clip.none,
                  onSwipeCompleted: (index, direction) => controller.onSwipeCompleted(index, direction, state, widget.swiController),
                  horizontalSwipeThreshold: 0.8,
                  verticalSwipeThreshold: 0.8,
                  itemCount: state.listNomination?.nominations?.length,
                  builder: (context, properties) {
                    if (length == 0) return const SizedBox();
                    final itemIndex = properties.index % length;
                    final data = nominations[itemIndex].listImage ?? [];
                    final pageController = PageController();
                    pageController.addListener(() {
                      context.read<HomeBloc>().add(HomeEvent(currentPage: pageController.page!.round()));
                    });
                    return Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.w),
                        child: Stack(
                          children: [
                            PageView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              controller: pageController,
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return PressHold(
                                    function: () => controller.gotoDetail(
                                      widget.swiController, state, itemIndex
                                    ),
                                    child: _boxCard(nominations, itemIndex, index, pageController)
                                );
                              },
                            ),
                            _contentInfoBottomCard(itemIndex, state)
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _error(HomeState state) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return SizedBox(
      height: heightScreen(context)*0.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 200.w,
            width: widthScreen(context)*0.6,
            child: Image.asset(ThemeImage.error),
          ),
          SizedBox(height: 20.w),
          Text('${state.message}', style: TextStyles.defaultStyle.setColor(themeNotifier.systemText)),
          SizedBox(height: 20.w),
          BlocBuilder<HomeBloc, HomeState>(builder: (context, store) {
            return SizedBox(
              width: widthScreen(context)/4,
              child: ButtonWidgetCustom(
                textButton: 'Retry',
                styleText: TextStyles.defaultStyle.bold.whiteText,
                color: ThemeColor.pinkColor,
                radius: 5.w,
                onTap: ()=> controller.getData(store.currentDistance!),
              ),
            );
          })
        ],
      ),
    );
  }

  Widget _boxCard(List<Nominations> data, int itemIndex, int index, PageController pageController) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Stack(
      children: [
        ColoredBox(
          color: themeNotifier.systemThemeFade,
          child: BlurHash(
            hash: "LEHV6nWB2yk8pyo0adR*.7kCMdnj",
            image: '${data[itemIndex].listImage?[index].image}',
            imageFit: BoxFit.cover,
          ),
        ),
        SizedBox(
            child: Row(
              children: [
                GestureDetector(
                    onTap: () => controller.backImage(pageController),
                    child: Container(width: 100.w,color: Colors.transparent)
                ),
                const Spacer(),
                GestureDetector(
                    onTap: () => controller.nextImage(pageController),
                    child: Container(width: 100.w,color: Colors.transparent)
                ),
              ],
            )
        )
      ],
    );
  }

  Widget _contentInfoBottomCard(int itemIndex, HomeState state) {
    final data = state.listNomination?.nominations;
    return Column(
      children: [
        BlocBuilder<HomeBloc, HomeState>(builder: (context, store) {
          return NumberOfPhotos(count: data?[itemIndex].listImage?.length, currentPage: store.currentPage);
        }),
        const Spacer(),
        SizedBox(
          height: 80.w,
          width: widthScreen(context),
          child: DecoratedBox(decoration: BoxDecoration(
            gradient: GradientColor.gradientBlackFade,
          )),
        ),
        SizedBox(
          height: 80.w,
          child: Material(
            color: ThemeColor.blackColor,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('${data?[itemIndex].info?.name}', style: TextStyles.defaultStyle.bold.whiteText.setTextSize(16.sp)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Text('•', style: TextStyles.defaultStyle.bold.whiteText.setTextSize(16.sp)),
                      ),
                      Text(
                          '${yearOld('${data?[itemIndex].info?.birthday}')} Age',
                          style: TextStyles.defaultStyle.bold.whiteText.setTextSize(16.sp)
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: ThemeColor.whiteColor),
                      Text(controller.calculateDistance(
                          latYou: state.info!.info!.lat!,
                          lonYou: state.info!.info!.lon!,
                          latOj: state.listNomination!.nominations![itemIndex].info!.lat!,
                          lonOj: state.listNomination!.nominations![itemIndex].info!.lon!
                      ), style: TextStyles.defaultStyle.whiteText)
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}