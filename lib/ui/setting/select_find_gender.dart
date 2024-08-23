import 'package:dating/common/global.dart';
import 'package:dating/common/textstyles.dart';
import 'package:dating/controller/setting_controller.dart';
import 'package:dating/theme/theme_image.dart';
import 'package:dating/theme/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SelectFindGender extends StatefulWidget {
  final SettingController controller;
  const SelectFindGender({super.key, required this.controller});

  @override
  State<SelectFindGender> createState() => _SelectFindGenderState();
}

class _SelectFindGenderState extends State<SelectFindGender> {
  late PageController pageController;
  final List<String> image = [ThemeImage.genderMaleHorizontal, ThemeImage.genderFeMaleHorizontal];

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.8, initialPage: widget.controller.initPage());
    pageController.addListener(() {
      final page = pageController.page?.round();
      if (page == 0) {
        Global.setString('gender', 'male');
      } else if (page == 1) {
        Global.setString('gender', 'female');
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 50.w),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.w),
        child: ColoredBox(
          color: themeNotifier.systemThemeFade,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 20.w),
                child: Row(
                  children: [
                    Text('Find', style: TextStyle(color: themeNotifier.systemText)),
                    const Spacer(),
                    Text('* Swipe to select gender', style: TextStyles.defaultStyle.italic.setTextSize(7.sp).setColor(themeNotifier.systemText.withOpacity(0.5))),
                  ],
                ),
              ),
              SizedBox(
                height: 200.w,
                width: double.infinity,
                child: PageView.builder(
                  controller: pageController,
                  itemCount: image.length,
                  clipBehavior: Clip.none,
                  itemBuilder: (context, index) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (pageController.page?.round() == 0) {
                        Global.setString('gender', 'male');
                      } else {
                        Global.setString('gender', 'female');
                      }
                    });
                    return Container(
                      clipBehavior: Clip.none,
                      width: 100,
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.w),
                          child: Image.asset(
                            image[index],
                            fit: BoxFit.cover,
                          )
                      ),
                    );

                  },
                ),
              ),
              SizedBox(height: 20.w)
            ],
          ),
        ),
      ),
    );
  }
}
