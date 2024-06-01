import 'package:dating/theme/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'mvc/ui/all_tap_bottom/all_tap/profile/bloc/edit_more_bloc.dart';
import 'mvc/ui/all_tap_bottom/all_tap/profile/bloc/upload_image_bloc.dart';
import 'mvc/ui/all_tap_bottom/bloc/all_tap_bloc.dart';

class MultiBloc extends StatelessWidget {
  final Widget child;

  const MultiBloc({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AllTapBloc(), lazy: true),
        BlocProvider(create: (context) => UploadImageBloc(), lazy: true),
        BlocProvider(create: (context) => EditMoreBloc(), lazy: true),
      ] ,
      child: ChangeNotifierProvider(
        create: (_) => ThemeNotifier(),
        child: child,
      ),
    );
  }
}
