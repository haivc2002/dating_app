
part of 'api_all_tap_bloc.dart';

class ApiAllTapState {}

class LoadApiAllTapState extends ApiAllTapState {}

class SuccessApiAllTapState extends ApiAllTapState {
  List<Results>? response;
  ModelInfoUser? info;

  SuccessApiAllTapState({this.response, this.info});
}