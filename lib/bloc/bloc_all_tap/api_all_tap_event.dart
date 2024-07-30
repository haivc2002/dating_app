
part of 'api_all_tap_bloc.dart';

class ApiAllTapEvent {}

class LoadApiAllTapEvent extends ApiAllTapEvent {}

class SuccessApiAllTapEvent extends ApiAllTapEvent {
  List<Results>? response;
  ModelInfoUser? info;

  SuccessApiAllTapEvent({this.response, this.info});
}