import 'package:dating/common/scale_screen.dart';
import 'package:dating/common/textstyles.dart';
import 'package:dating/controller/setting_controller/setting_controller.dart';
import 'package:dating/theme/theme_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

import '../../../theme/theme_notifier.dart';
import '../../bloc/bloc_all_tap/api_all_tap_bloc.dart';
import '../about_app/about_app_screen.dart';

class SettingScreen extends StatefulWidget {
  static const String routeName = 'settingScreen';
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late ThemeNotifier themeNotifier;
  late SettingController controller;
  MapController mapController = MapController();

  @override
  void initState() {
    super.initState();
    controller = SettingController(context);
    controller.preload(setState);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    themeNotifier = Provider.of<ThemeNotifier>(context);
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      color: themeNotifier.systemTheme,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Container(
              height: 120.w,
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(CupertinoIcons.back, color: themeNotifier.systemText),
                  ),
                  SizedBox(width: 10.w),
                  Text('Setting', style: TextStyles.defaultStyle.bold.appbarTitle),
                ],
              ),
            ),
            Expanded(child: item())
          ],
        ),
      ),
    );
  }

  Widget item() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: SingleChildScrollView(
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: EdgeInsets.symmetric(vertical: 20.w),
              decoration: BoxDecoration(
                color: themeNotifier.systemThemeFade,
                borderRadius: BorderRadius.circular(10.w)
              ),
              child: Column(
                children: [
                  cartAnimate(
                    Text(controller.isDarkMode ? 'Light mode' : 'Dark mode'),
                    IconButton(
                      onPressed: ()=> controller.toggleTheme(setState),
                      icon: AnimatedCrossFade(
                        duration: const Duration(milliseconds: 300),
                        firstChild: const Icon(Icons.dark_mode, key: ValueKey('light')),
                        secondChild: const Icon(Icons.light_mode, key: ValueKey('dark'), color: Colors.white),
                        crossFadeState: controller.isDarkMode ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                      ),
                    ),
                    () => controller.toggleTheme(setState),
                  ),
                  Transform.scale(
                    scale: 0.9,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.w),
                      child: SizedBox(
                        height: 200.w,
                        width: widthScreen(context),
                        child: controller.fileRive == null
                            ? const SizedBox.shrink()
                            : RiveAnimation.direct(
                          controller.fileRive!,
                          fit: BoxFit.cover,
                          onInit: (artBoard) {
                            StateMachineController riveController = controller.getRiveController(artBoard);
                            controller.dark = riveController.findSMI('Trigger 1') as SMITrigger?;
                            controller.light = riveController.findSMI('Trigger 2') as SMITrigger?;
                            WidgetsBinding.instance.addPostFrameCallback((_) => controller.triggerAnimation());
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            cartAnimate(
              const Text('Account'),
              Text('data', style: TextStyles.defaultStyle.setColor(themeNotifier.systemText)),
                  () => Navigator.pushNamed(context, AboutAppScreen.routeName),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                color: themeNotifier.systemThemeFade,
                borderRadius: BorderRadius.circular(10.w),
              ),
              margin: EdgeInsets.only(bottom: 15.w),
              padding: EdgeInsets.all(10.w),
              child: BlocBuilder<ApiAllTapBloc, ApiAllTapState>(builder: (context, state) {
                if(state is SuccessApiAllTapState) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text('${controller.currentDistance.round()}km', style: TextStyles.defaultStyle.setColor(themeNotifier.systemText)),
                        subtitle: Slider(
                          activeColor: ThemeColor.pinkColor,
                          value: controller.currentDistance,
                          min: 1,
                          max: 20,
                          divisions: 19,
                          onChanged: (value) {
                            setState(() {
                              controller.currentDistance = value;
                              mapController.move(
                                LatLng(state.response?[0].lat??0, state.response?[0].lon??0),
                                controller.sizeMap()
                              );
                            });
                          },
                        ),
                      ),
                      _map(state)
                    ],
                  );
                } else {
                  return Text('Máy chủ bận');
                }
              })
            ),
            cartAnimate(
              const Text('About application'),
              Icon(Icons.arrow_forward_ios, size: 15.sp, color: themeNotifier.systemText),
                  () => Navigator.pushNamed(context, AboutAppScreen.routeName),
            ),
            cartAnimate(
              const Text('I need to find'),
              Text('woman', style: TextStyles.defaultStyle.setColor(themeNotifier.systemText)),
                  () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget cartAnimate(Widget widgetStart, Widget widgetEnd, Function() onTap) {
    return AnimatedContainer(
      height: 70.w,
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: themeNotifier.systemThemeFade,
        borderRadius: BorderRadius.circular(10.w),
      ),
      margin: EdgeInsets.only(bottom: 15.w),
      padding: EdgeInsets.all(10.w),
      child: ListTile(
        onTap: onTap,
        leading: AnimatedDefaultTextStyle(
          style: TextStyle(color: themeNotifier.systemText),
          duration: const Duration(milliseconds: 300),
          child: widgetStart,
        ),
        trailing: widgetEnd,
      ),
    );
  }

  Widget _map(SuccessApiAllTapState state) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.w),
      child: SizedBox(
        height: heightScreen(context)/3,
        child: IgnorePointer(
        ignoring: true,
        child: FlutterMap(
          mapController: mapController,
          options: MapOptions(
            initialCenter: LatLng(state.response?[0].lat??0, state.response?[0].lon??0),
            initialZoom: controller.sizeMap()
          ),
          children: [
            TileLayer(
                urlTemplate: 'https://api.maptiler.com/maps/streets/{z}/{x}/{y}.png?key=4mjr9TMaEoYEKYaRJUin',
                subdomains: const ['a', 'b', 'c'],
                tileBuilder: controller.isDarkMode ? _darkModeTileBuilder : null,
            ),
            MarkerLayer(markers: [Marker(
                width: 80,
                height: 80,
                point: LatLng(state.response?[0].lat??0, state.response?[0].lon??0),
                child: Icon(Icons.location_on, size: 30.sp, color: ThemeColor.deepRedColor)
            )]),
            CircleLayer(
              circles: [
                CircleMarker(
                  point: LatLng(state.response?[0].lat??0, state.response?[0].lon??0),
                  color: ThemeColor.pinkColor.withOpacity(0.1),
                  borderStrokeWidth: 2,
                  borderColor: ThemeColor.pinkColor,
                  radius: 120.sp,
                ),
              ],
            ),
          ],
        ))
      ),
    );
  }

  Widget _darkModeTileBuilder(
      BuildContext context,
      Widget tileWidget,
      TileImage tile,
      ) {
    return ColorFiltered(
      colorFilter: const ColorFilter.matrix(<double>[
        -0.2126, -0.7152, 0.0722, 0, 255,
        -0.2126, -0.7152, 0.0722, 0, 255,
        -0.2126, -0.7152, 0.0722, 0, 255,
        0,       0,       0,       1, 0,
      ]),
      child: tileWidget,
    );
  }

}
