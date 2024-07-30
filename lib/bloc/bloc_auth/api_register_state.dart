

part of 'api_register_bloc.dart';

class ApiRegisterState {
  int? a;
  ApiRegisterState({this.a});
}

class LoadApiRegisterState extends ApiRegisterState {}

class SuccessApiRegisterState extends ApiRegisterState {
  ModelBase? response;

  SuccessApiRegisterState({this.response, int? a}) : super(a: a);
}