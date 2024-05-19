import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../theme/theme_color.dart';
import '../../../../tool_widget_custom/appbar_custom.dart';
import '../../../extension/textstyles.dart';

class PremiumScreen extends StatefulWidget {
  final AnimationController animationController;
  const PremiumScreen({Key? key, required this.animationController}) : super(key: key);

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBarCustom(
        title: 'Dash Date',
        leadingIcon: Builder(
            builder: (context) {
              return GestureDetector(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                  setState(() {
                    widget.animationController.forward();
                  });
                },
                child: Container(
                  color: Colors.white,
                  child: const Center(
                    child: Icon(Icons.menu),
                  ),
                ),
              );
            }
        ),
        textStyle: TextStyles.defaultStyle.bold.setColor(ThemeColor.pinkColor).setTextSize(18.sp),
      ),
    );
  }
}
