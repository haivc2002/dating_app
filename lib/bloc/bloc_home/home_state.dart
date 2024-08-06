

part of 'home_bloc.dart';

class HomeState {
  String? message;

  HomeState({this.message});
}

class LoadApiHomeState extends HomeState {}

class SuccessApiHomeState extends HomeState {
  final ModelListNomination? listNomination;
  final ModelInfoUser? info;
  final List<Results>? location;

  SuccessApiHomeState({this.listNomination, this.info, this.location});
}

class ErrorApiHomeState extends HomeState {
  ErrorApiHomeState({String? message}) : super(message: message);
}
