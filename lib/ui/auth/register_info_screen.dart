import 'dart:io';
import 'dart:ui';

import 'package:dating/bloc/bloc_auth/register_bloc.dart';
import 'package:dating/bloc/bloc_profile/edit_bloc.dart';
import 'package:dating/common/scale_screen.dart';
import 'package:dating/common/textstyles.dart';
import 'package:dating/controller/register_more_controller.dart';
import 'package:dating/theme/theme_color.dart';
import 'package:dating/theme/theme_image.dart';
import 'package:dating/theme/theme_notifier.dart';
import 'package:dating/tool_widget_custom/button_widget_custom.dart';
import 'package:dating/tool_widget_custom/input_custom.dart';
import 'package:dating/tool_widget_custom/item_card.dart';
import 'package:dating/tool_widget_custom/select_gender.dart';
import 'package:dating/tool_widget_custom/wait.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../../bloc/bloc_all_tap/api_all_tap_bloc.dart';
import '../../service/access_photo_gallery.dart';
import '../../tool_widget_custom/box_photo.dart';

class RegisterInfoScreen extends StatefulWidget {
  static const String routeName = 'registerMoreScreen';
  const RegisterInfoScreen({super.key});

  @override
  State<RegisterInfoScreen> createState() => _RegisterInfoScreenState();
}

class _RegisterInfoScreenState extends State<RegisterInfoScreen> {

  late RegisterMoreController controller;
  late AccessPhotoGallery photoGallery;

  @override
  void initState() {
    super.initState();
    controller = RegisterMoreController(context);
    controller.checkLocationPermission();
    controller
        .draggableScrollableController
        .addListener(controller.scrollListener);
    context.read<RegisterBloc>().add(RegisterEvent(appBarHeightFactor: 0.35));
    photoGallery = AccessPhotoGallery(context);
  }

  @override
  void dispose() {
    controller
        .draggableScrollableController
        .removeListener(controller.scrollListener);
    controller.draggableScrollableController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return GestureDetector(
      onTap: controller.tapDismiss,
      child: Scaffold(
        backgroundColor: themeNotifier.systemTheme,
        body: Stack(
          children: [
            DraggableScrollableSheet(
              controller: controller.draggableScrollableController,
              initialChildSize: 0.65,
              minChildSize: 0.65,
              maxChildSize: 1,
              builder: (context, scrollController) {
                return _mustBeComplete(scrollController);
              },
            ),
            _appBarAvt()
          ],
        ),
      ),
    );
  }

  Widget _mustBeComplete(ScrollController scrollController) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        children: [
          Container(
            width: widthScreen(context),
            margin: EdgeInsets.symmetric(vertical: 20.w, horizontal: 10.w),
            padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 10.w),
            decoration: BoxDecoration(
              color: themeNotifier.systemThemeFade,
              borderRadius: BorderRadius.circular(10.w)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.w),
                _input(title: 'Your name', controller: controller.nameController),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.w),
                  child: Text('Your birthday', style: TextStyles.defaultStyle.setColor(themeNotifier.systemText)),
                ),
                BlocBuilder<RegisterBloc, RegisterState>(
                  builder: (context, store) {
                    return Row(
                      children: [
                        Expanded(flex: 2, child: _boxDate(store.birthdayValue == null ? 'dd' : DateFormat('dd').format(store.birthdayValue!))),
                        SizedBox(width: 10.w),
                        Expanded(flex: 2, child: _boxDate(store.birthdayValue == null ? 'MM' : DateFormat('MM').format(store.birthdayValue!))),
                        SizedBox(width: 10.w),
                        Expanded(flex: 3, child: _boxDate(store.birthdayValue == null ? 'yyyy' : DateFormat('yyyy').format(store.birthdayValue!))),
                      ],
                    );
                  }
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.w),
                  child: Text('Your location', style: TextStyles.defaultStyle.setColor(themeNotifier.systemText)),
                ),
                BlocBuilder<ApiAllTapBloc, ApiAllTapState>(builder: (context, state) {
                  if(state is LoadApiAllTapState) {
                    return _wait();
                  } else if(state is SuccessApiAllTapState) {
                    return Column(
                      children: [
                        Material(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(10.w)),
                          color: ThemeColor.themeLightSystem,
                          child: ListTile(
                            onTap: ()=> controller.getLocation(),
                            leading: const Icon(Icons.location_on),
                            title: const Text('I\'m in:'),
                            trailing: Text(controller.city(state)),
                          ),
                        ),
                        _map(state),
                      ],
                    );
                  } else {
                    return Center(
                      child: SizedBox(
                        width: widthScreen(context)*0.7,
                        child: Image.asset(ThemeImage.error),
                      ),
                    );
                  }
                }),
                SizedBox(height: 20.w),
                BlocBuilder<EditBloc, EditState>(
                  builder: (context, state) {
                    return ItemCard(
                      titleColor: ThemeColor.blackColor,
                      titleCard: 'I came here to: ${state.purposeValue}',
                      iconTitle: const Icon(CupertinoIcons.square_stack_3d_up_fill),
                      colorCard: ThemeColor.themeLightSystem,
                      onTap: ()=> controller.popupPurpose(),
                    );
                  }
                ),
                const SelectGender(),
              ],
            ),
          ),
          Text('Select photo (minimum 1 photo)', style: TextStyles.defaultStyle.bold.appbarTitle),
          BoxPhoto(function: (index) => photoGallery.selectImage(index)),
          Container(
            color: themeNotifier.systemThemeFade,
            width: widthScreen(context),
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.w),
                child: GestureDetector(
                  onTap: ()=> controller.registerInfo(setState),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.fastEaseInToSlowEaseOut,
                    width: controller.isLoading ? 40.w : widthScreen(context)*0.9,
                    decoration: BoxDecoration(
                      color: themeNotifier.systemText,
                      borderRadius: BorderRadius.circular(100.w)
                    ),
                    height: 40.w,
                    child: Center(
                      child: controller.isLoading
                          ? Wait(color: themeNotifier.systemTheme)
                          : Text('finished', style: TextStyles.defaultStyle.setColor(themeNotifier.systemTheme).bold),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _input({required String title,bool? typeNumber, TextEditingController? controller, FocusNode? focusNode}) {
    return InputCustom(
      labelText: title,
      colorInput: ThemeColor.themeLightSystem,
      labelColor: ThemeColor.blackColor.withOpacity(0.5),
      colorText: ThemeColor.blackColor.withOpacity(0.8),
      keyboardType: typeNumber == true ? TextInputType.number : null,
      controller: controller,
      focusNode: focusNode,
    );
  }

  Widget _boxDate(String title) {
    return GestureDetector(
      onTap: ()=> controller.selectDate(),
      child: Container(
        height: 50.w,
        decoration: BoxDecoration(
          color: ThemeColor.themeLightSystem,
          borderRadius: BorderRadius.circular(10.w)
        ),
        child: Center(
          child: Text(title, style: TextStyles.defaultStyle.setColor(ThemeColor.blackColor.withOpacity(0.5))),
        ),
      ),
    );
  }

  Widget _map(SuccessApiAllTapState state) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(10.w)),
      child: SizedBox(
          height: heightScreen(context)/3,
          child: IgnorePointer(
              ignoring: true,
              child: FlutterMap(
                // mapController: mapController,
                options: MapOptions(
                    initialCenter: LatLng(state.response?[0].lat??0, state.response?[0].lon??0),
                    initialZoom: 13
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://api.maptiler.com/maps/streets/{z}/{x}/{y}.png?key=4mjr9TMaEoYEKYaRJUin',
                    subdomains: const ['a', 'b', 'c'],
                  ),
                  MarkerLayer(markers: [Marker(
                      width: 80,
                      height: 80,
                      point: LatLng(state.response?[0].lat??0, state.response?[0].lon??0),
                      child: Icon(Icons.location_on, size: 30.sp, color: ThemeColor.deepRedColor)
                  )]),
                ],
              ))
      ),
    );
  }

  Widget _wait() {
    return Column(
      children: [
        Material(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10.w)),
          color: ThemeColor.themeLightSystem.withOpacity(0.8),
          child: ListTile(
            onTap: ()=> controller.getLocation(),
            leading: const Icon(Icons.location_on),
            title: const Text('I\'m in:'),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10.w)),
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: heightScreen(context)/3,
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaY: 0, sigmaX: 0),
                  child: Image.asset(ThemeImage.mapBlur, fit: BoxFit.cover),
                ),
              ),
              controller.isGranted
                ? const Wait(color: ThemeColor.whiteColor)
                : SizedBox(
                width: widthScreen(context)*0.7,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(CupertinoIcons.info, color: ThemeColor.whiteColor),
                    const SizedBox(width: 10),
                    Expanded(child: Text('Location access permission has \nnot been granted, tap to proceed', style: TextStyles.defaultStyle.whiteText))
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _appBarAvt() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
            double heightApp = constraints.maxHeight * (state.appBarHeightFactor??0.35);
            return Stack(
              children: [
                BlocBuilder<EditBloc, EditState>(
                  builder: (context, photo) {
                    File? backgroundUpload;
                    if (photo.imageUpload != null && photo.imageUpload!.isNotEmpty) {
                      backgroundUpload = photo.imageUpload![0];
                    }
                    return SizedBox(
                      height: heightApp,
                      width: widthScreen(context),
                      child: Opacity(
                        opacity: 0.3,
                        child: backgroundUpload != null 
                          ? Image.file(backgroundUpload, fit: BoxFit.cover)
                          : Image.asset(ThemeImage.avatarNone, fit: BoxFit.cover)
                      ),
                    );
                  }
                ),
                SizedBox(
                  height: heightApp,
                  child: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: SizedBox(
                        child: _avatar(heightApp, state),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        );
      },
    );
  }

  Widget _avatar(double heightApp, RegisterState state) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => photoGallery.selectImage(0),
          child: BlocBuilder<EditBloc, EditState>(
              builder: (context, photo) {
                File? backgroundUpload;
                if (photo.imageUpload != null && photo.imageUpload!.isNotEmpty) {
                  backgroundUpload = photo.imageUpload![0];
                }
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  height: state.appBarHeightFactor! > 0.28 ? heightScreen(context) * 0.35 : heightApp / 2,
                  width: state.appBarHeightFactor! > 0.28 ? widthScreen(context) : heightApp / 2,
                  margin: EdgeInsets.symmetric(horizontal: state.appBarHeightFactor! > 0.28 ? 0 : 20.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(state.appBarHeightFactor! > 0.28 ? 10.w : 100.w),
                    image: DecorationImage(
                      image: backgroundUpload != null
                          ? FileImage(backgroundUpload) as ImageProvider
                          : const AssetImage(ThemeImage.avatarNone),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }
          ),
        ),
      ],
    );
  }



}
