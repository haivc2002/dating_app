
import 'package:dating/common/global.dart';
import 'package:dating/model/model_response_match.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/location_model/location_current_model.dart';
import '../../model/model_info_user.dart';
import '../../model/model_list_nomination.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState(
    isLoading: false,
    currentDistance: Global.getInt('currentDistance', def: 1),
    currentPage: 0,
    currentIndex: 0
  )) {
    on<HomeEvent>((event, emit) {
      emit(HomeState(
        message: event.message ?? state.message,
        info: event.info ?? state.info,
        listNomination: event.listNomination ?? state.listNomination,
        location: event.location ?? state.location,
        match: event.match ?? state.match,

        currentDistance: event.currentDistance ?? state.currentDistance,
        currentIndex: event.currentIndex ?? state.currentIndex,
        currentPage: event.currentPage ?? state.currentPage,
        isLoading: event.isLoading ?? state.isLoading,
      ));
    });
  }
}

