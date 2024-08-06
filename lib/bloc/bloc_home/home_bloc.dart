
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/location_model/location_current_model.dart';
import '../../model/model_info_user.dart';
import '../../model/model_list_nomination.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState()) {
    on<LoadApiHomeEvent>((event, emit) {
      emit(LoadApiHomeState());
    });
    on<SuccessApiHomeEvent>((event, emit) {
      final currentState = state;
      if (currentState is SuccessApiHomeState) {
        emit(SuccessApiHomeState(
          listNomination: event.listNomination ?? currentState.listNomination,
          info: event.info ?? currentState.info,
          location: event.location ?? currentState.location,
        ));
      } else {
        emit(SuccessApiHomeState(
          listNomination: event.listNomination,
          info: event.info,
          location: event.location,
        ));
      }
    });

    on<ErrorApiHomeEvent>((event, emit) {
      emit(ErrorApiHomeState(message: event.message));
    });
  }
}

