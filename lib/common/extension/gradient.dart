import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../theme/theme_color.dart';

extension GradientColor on LinearGradient {

  static LinearGradient get backgroundScaffoldGradient {
    return LinearGradient(
        colors: [ThemeColor.themeDarkSystem.withOpacity(0.5), ThemeColor.themeDarkSystem],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter
    );
  }

  static LinearGradient get gradientPremium {
    return const LinearGradient(
        colors: [ThemeColor.golderColor, ThemeColor.golderFadeColor],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight
    );
  }

  static LinearGradient get gradientBlackFade {
    return LinearGradient(
        colors: [ThemeColor.blackColor.withOpacity(0), ThemeColor.blackColor],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter
    );
  }
}