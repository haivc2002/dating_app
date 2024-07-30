

part of 'home_bloc.dart';

class HomeEvent {}

class LoadApiHomeEvent extends HomeEvent {}

class SuccessApiHomeEvent extends HomeEvent {
  ModelListNomination listNomination;

  SuccessApiHomeEvent(this.listNomination);
}