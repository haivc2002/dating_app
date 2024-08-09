

import 'package:dating/model/model_info_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc() : super(LoadDetailState()) {
    on<LoadDetailEvent>((event, emit) {
      emit(LoadDetailState());
    });
    on<SuccessDetailEvent>((event, emit) {
      emit(SuccessDetailState(response: event.response));
    });
  }
}