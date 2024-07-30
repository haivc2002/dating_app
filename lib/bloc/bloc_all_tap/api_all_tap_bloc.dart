

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/location_model/location_current_model.dart';
import '../../model/model_info_user.dart';

part 'api_all_tap_event.dart';
part 'api_all_tap_state.dart';

class ApiAllTapBloc extends Bloc<ApiAllTapEvent, ApiAllTapState> {
  ApiAllTapBloc() : super(LoadApiAllTapState()) {
    on<LoadApiAllTapEvent>((event, emit) {
      emit(LoadApiAllTapState());
    });
    on<SuccessApiAllTapEvent>((event, emit) {
      final current = state;
      if(current is SuccessApiAllTapState) {
        emit(SuccessApiAllTapState(
          response: event.response ?? current.response,
          info: event.info ?? current.info
        ));
      } else {
        emit(SuccessApiAllTapState(
          response: event.response,
          info: event.info,
        ));
      }
    });
  }
}