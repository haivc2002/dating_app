
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/model_outside_view_message.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  MessageBloc() : super(LoadMessageState()) {
    on<LoadMessageEvent>((event, emit) {
      emit(LoadMessageState());
    });
    on<SuccessMessageEvent>((event, emit) {
      emit(SuccessMessageState(response: event.response));
    });
  }
}