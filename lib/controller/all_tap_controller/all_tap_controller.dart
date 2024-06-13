import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bloc_all_tap/all_tap_bloc.dart';

class AllTapController {
  BuildContext context;
  int selectedIndex = 0;
  PageController pageController= PageController();
  AllTapController(this.context);

  void onItemTapped(int index) {
    selectedIndex = index;
    context.read<AllTapBloc>().add(AllTapEvent(selectedIndex));
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
  }

  void openDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

}