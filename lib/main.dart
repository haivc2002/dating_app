import 'package:dating/theme/theme_color.dart';
import 'package:dating/ui/%20preamble/hello_screen.dart';
import 'package:dating/ui/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ColorPaletteProvider(
      themeColor: ThemeColor(),
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_ , child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'First Method',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            onGenerateRoute: AppRouter.generateRoute,
            home: child,
          );
        },
        // child: const SliderScreen(),
        // child: const AnimateToNextScreen(),
        child: const HelloScreen(),
      ),
    );
  }
}
