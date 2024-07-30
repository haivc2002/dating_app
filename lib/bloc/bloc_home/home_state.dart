

part of 'home_bloc.dart';

class HomeState {}

class LoadApiHomeState extends HomeState {}

class SuccessApiHomeState extends HomeState {
  ModelListNomination listNomination;

  SuccessApiHomeState({required this.listNomination});
}