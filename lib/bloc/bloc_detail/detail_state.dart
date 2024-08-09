
part of 'detail_bloc.dart';

class DetailState {}

class LoadDetailState extends DetailState {}

class SuccessDetailState extends DetailState {
  final ModelInfoUser response;

  SuccessDetailState({required this.response});
}