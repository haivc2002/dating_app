

part of 'api_register_bloc.dart';

class ApiRegisterEvent {
  int? a;

  ApiRegisterEvent({this.a});
}

class LoadApiRegisterEvent extends ApiRegisterEvent {}

class SuccessApiRegisterEvent extends ApiRegisterEvent {
  ModelBase? response;

  SuccessApiRegisterEvent({this.response, int? a}): super(a: a);
}