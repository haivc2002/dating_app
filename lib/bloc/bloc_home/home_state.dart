

part of 'home_bloc.dart';

class HomeState {
  String? message;
  int? currentPage;
  int? currentIndex;
  int? currentDistance;
  bool? isLoading;
  final ModelListNomination? listNomination;
  final ModelInfoUser? info;
  final List<Results>? location;
  final ModelResponseMatch? match;

  HomeState({
    this.message,
    this.isLoading,
    this.currentPage,
    this.currentIndex,
    this.currentDistance,
    this.listNomination,
    this.info,
    this.location,
    this.match
  });
}
