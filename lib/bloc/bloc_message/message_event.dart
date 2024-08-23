
part of 'message_bloc.dart';

class MessageEvent {}

class LoadMessageEvent extends MessageEvent {}

class SuccessMessageEvent extends MessageEvent {
  List<Conversations> response;

  SuccessMessageEvent(this.response);
}

