import 'package:dating/ui/all_tap_bottom/bloc/all_tap_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
}