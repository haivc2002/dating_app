
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/model_response_message.dart';

part 'detail_message_event.dart';
part 'detail_message_state.dart';

class DetailMessageBloc extends Bloc<DetailMessageEvent, DetailMessageState> {
  DetailMessageBloc() : super(DetailMessageState(response: [])) {
    on<DetailMessageEvent>((event, emit) {
      emit(DetailMessageState(response: event.response ?? state.response));
    });
  }
}