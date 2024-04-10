import 'dart:ui';

import 'package:dating/theme/theme_color.dart';
import 'package:dating/ui/auth/login_screen.dart';
import 'package:dating/ui/tool_widget_custom/button_widget_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SliderScreen extends StatefulWidget {
  const SliderScreen({Key? key}) : super(key: key);

  @override
  State<SliderScreen> createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {
  int item = 0;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.4), Colors.black],
                    end: Alignment.bottomCenter,
                    begin: Alignment.topCenter)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Center(
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      image: AssetImage('assets/Screenshot_1.png')
                    )
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Text('Dash Date', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30.sp, color: ThemeColor.whiteColor)),
              ),
              SizedBox(
                height: 100,
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  children: [
                    contentText('Found the right friend for you? Search immediately.'),
                    contentText('gives you the best features'),
                    contentText('make friends and chat with people around us'),
                  ],
                ),
              ),
              ButtonWidgetCustom(
                symetric: EdgeInsets.symmetric(vertical: 50.h, horizontal: 20.w),
                radius: 100,
                height: 50,
                textButton: 'Next',
                styleText: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500),
                color: ThemeColor.whiteColor.withOpacity(0.5),
                onTap: () {
                  if(_currentPage == 2) {
                    Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName, (route) => false);
                  } else {
                    _pageController.animateToPage(
                      _currentPage + 1,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
              )

            ],
          )
        ],
      ),
    );
  }

  Widget contentText(String? dataText) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 0, 100.w, 0),
      child: Text(
      dataText ?? '',
      style: TextStyle(color: ThemeColor.whiteColor.withOpacity(0.7))),
    );
  }
}
