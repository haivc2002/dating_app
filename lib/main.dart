import 'package:dating/theme/theme_color.dart';
import 'package:dating/ui/all_tap_bottom/all_tap_bottom_screen.dart';
import 'package:dating/ui/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'common/global.dart';
import 'multibloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Global.load();
  runApp(
      const MultiBloc(child: MyApp())
  );
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
        // child: const HelloScreen(),
        child: const AllTapBottomScreen(),
      ),
    );
  }
}
