import 'package:dating/ui/all_tap_bottom/all_tap/profile/service/bloc/upload_image_bloc.dart';
import 'package:dating/ui/all_tap_bottom/bloc/all_tap_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MultiBloc extends StatelessWidget {
  final Widget child;

  const MultiBloc({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AllTapBloc(), lazy: true),
        BlocProvider(create: (context) => UploadImageBloc(), lazy: true),
      ] ,
      child: child,
    );
  }
}
