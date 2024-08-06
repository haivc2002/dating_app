

part of 'home_bloc.dart';

class HomeEvent {}

class LoadApiHomeEvent extends HomeEvent {}

class SuccessApiHomeEvent extends HomeEvent {
  final ModelListNomination? listNomination;
  final ModelInfoUser? info;
  final List<Results>? location;

  SuccessApiHomeEvent({this.listNomination, this.info, this.location});
}

class ErrorApiHomeEvent extends HomeEvent {
  String message;

  ErrorApiHomeEvent(this.message);
}