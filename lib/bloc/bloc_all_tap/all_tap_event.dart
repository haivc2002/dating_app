

part of '../../../bloc/bloc_all_tap/all_tap_bloc.dart';

class AllTapEvent {
  int? selectedIndex;
  bool? drawerStatus;
  int? matchCount;
  int? messageCount;

  AllTapEvent({this.selectedIndex, this.drawerStatus, this.matchCount, this.messageCount});
}