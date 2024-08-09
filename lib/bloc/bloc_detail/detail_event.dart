

part of 'detail_bloc.dart';

class DetailEvent {}

class LoadDetailEvent extends DetailEvent {}

class SuccessDetailEvent extends DetailEvent {
  final ModelInfoUser response;

  SuccessDetailEvent(this.response);
}