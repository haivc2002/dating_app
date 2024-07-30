import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/theme_color.dart';

class TextStyles {
  TextStyles(this.context);

  BuildContext? context;
  static TextStyle defaultStyle = TextStyle(
    fontSize: 12.sp,
    color: ThemeColor.blackColor,
    fontWeight: FontWeight.w400,
  );

}

extension ExtendedTextStyle on TextStyle {
  TextStyle get light {
    return copyWith(fontWeight: FontWeight.w300);
  }

  TextStyle get regular {
    return copyWith(fontWeight: FontWeight.w400);
  }

  TextStyle get medium {
    return copyWith(fontWeight: FontWeight.w500);
  }

  TextStyle get bold {
    return copyWith(fontWeight: FontWeight.w700);
  }

  TextStyle get appbarTitle {
    return copyWith(fontSize: 18.sp, color: ThemeColor.pinkColor);
  }

  TextStyle get whiteText {
    return copyWith(color: ThemeColor.whiteColor);
  }

  TextStyle get systemColor {
    return copyWith(color: ThemeColor.whiteColor);
  }

  TextStyle get italic {
    return copyWith(
      fontWeight: FontWeight.normal,
      fontStyle: FontStyle.italic,
    );
  }

  TextStyle setColor(Color color) {
    return copyWith(color: color);
  }

  TextStyle setTextSize(double size) {
    return copyWith(fontSize: size);
  }


}