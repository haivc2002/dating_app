import 'package:flutter/cupertino.dart';

import '../theme/theme_color.dart';

extension GradientColor on LinearGradient {

  static LinearGradient get backgroundScaffoldGradient {
    return LinearGradient(
        colors: [ThemeColor.backgroundScaffold.withOpacity(0.5), ThemeColor.backgroundScaffold],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter
    );
  }
}