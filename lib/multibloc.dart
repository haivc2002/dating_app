import 'package:dating/bloc/bloc_all_tap/all_tap_bloc.dart';
import 'package:dating/theme/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'bloc/bloc_all_tap/api_all_tap_bloc.dart';
import 'bloc/bloc_auth/api_register_bloc.dart';
import 'bloc/bloc_auth/register_bloc.dart';
import 'bloc/bloc_detail/detail_bloc.dart';
import 'bloc/bloc_home/home_bloc.dart';
import 'bloc/bloc_premium/premium_bloc.dart';
import 'bloc/bloc_profile/edit_bloc.dart';
import 'bloc/bloc_profile/store_edit_more_bloc.dart';
import 'bloc/bloc_search_autocomplete/autocomplete_bloc.dart';

class MultiBloc extends StatelessWidget {
  final Widget child;

  const MultiBloc({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AllTapBloc(), lazy: true),
        BlocProvider(create: (context) => EditBloc(), lazy: true),
        BlocProvider(create: (context) => StoreEditMoreBloc(), lazy: true),
        BlocProvider(create: (context) => AutocompleteBloc(), lazy: true),
        BlocProvider(create: (context) => ApiAllTapBloc(), lazy: true),
        BlocProvider(create: (context) => RegisterBloc(), lazy: true),
        BlocProvider(create: (context) => ApiRegisterBloc(), lazy: true),
        BlocProvider(create: (context) => HomeBloc(), lazy: true),
        BlocProvider(create: (context) => PremiumBloc(), lazy: true),
        BlocProvider(create: (context) => DetailBloc(), lazy: true),
      ] ,
      child: ChangeNotifierProvider(
        create: (_) => ThemeNotifier(),
        child: child,
      ),
    );
  }
}
