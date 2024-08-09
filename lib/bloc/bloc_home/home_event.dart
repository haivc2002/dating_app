

part of 'home_bloc.dart';

class HomeEvent {
  String? message;
  int? currentPage;
  int? currentIndex;
  int? currentDistance;
  bool? isLoading;
  final ModelListNomination? listNomination;
  final ModelInfoUser? info;
  final List<Results>? location;
  final ModelResponseMatch? match;

  HomeEvent({
    this.isLoading,
    this.message,
    this.currentPage,
    this.currentIndex,
    this.currentDistance,
    this.listNomination,
    this.info,
    this.location,
    this.match
  });
}