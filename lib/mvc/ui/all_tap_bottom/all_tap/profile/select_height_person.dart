import 'package:dating/common/scale_screen.dart';
import 'package:dating/common/textstyles.dart';
import 'package:dating/common/textstyles.dart';
import 'package:dating/common/textstyles.dart';
import 'package:dating/theme/theme_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../theme/theme_notifier.dart';

class SelectHeightPerson extends StatefulWidget {
  static const String routeName = 'selectHeightPerson';
  const SelectHeightPerson({Key? key}) : super(key: key);

  @override
  State<SelectHeightPerson> createState() => _SelectHeightPersonState();
}

class _SelectHeightPersonState extends State<SelectHeightPerson> {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Scaffold(
            backgroundColor: ThemeColor.blackColor.withOpacity(0.6),
          ),
        ),
        SizedBox(
          height: heightScreen(context),
          width: widthScreen(context),
          child: Center(
            child: Hero(
              tag: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.w),
                child: SizedBox(
                  height: heightScreen(context)*0.5,
                  width: widthScreen(context)*0.8,
                  child: Material(
                    color: themeNotifier.systemThemeFade,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
                          child: Row(
                            children: [
                              Icon(Icons.height, color: themeNotifier.systemText),
                              SizedBox(width: 10.w),
                              Text('Height', style: TextStyles.defaultStyle.bold.setColor(themeNotifier.systemText)),
                              const Spacer(),
                              Text('data', style: TextStyles.defaultStyle.bold.setColor(themeNotifier.systemText))
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: 101,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {},
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10.w),
                                  child: test(index)
                                )
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget test(int index) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    if(index == 0) {
      return Text('lower 100cm', textAlign: TextAlign.center, style: TextStyles.defaultStyle.setColor(themeNotifier.systemText),);
    } else if (index == 100) {
      return Text('higher 200cm', textAlign: TextAlign.center, style: TextStyles.defaultStyle.setColor(themeNotifier.systemText),);
    } else {
      return Text('${index+100}cm', textAlign: TextAlign.center, style: TextStyles.defaultStyle.setColor(themeNotifier.systemText),);
    }
  }
}
