
part of 'message_bloc.dart';

class MessageState {}

class LoadMessageState extends MessageState {}

class SuccessMessageState extends MessageState {
  List<Conversations> response;

  SuccessMessageState({required this.response});
}