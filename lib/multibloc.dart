import 'package:dating/theme/theme_notifier.dart';
import 'package:dating/bloc/bloc_all_tap/all_tap_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'bloc/bloc_all_tap/get_location_bloc.dart';
import 'bloc/bloc_profile/edit_more_bloc.dart';
import 'bloc/bloc_profile/upload_image_bloc.dart';
import 'bloc/bloc_search_autocomplete/autocomplete_bloc.dart';

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
        BlocProvider(create: (context) => AutocompleteBloc(), lazy: true),
        BlocProvider(create: (context) => GetLocationBloc(), lazy: true),
      ] ,
      child: ChangeNotifierProvider(
        create: (_) => ThemeNotifier(),
        child: child,
      ),
    );
  }
}
