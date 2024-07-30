
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/model_list_nomination.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState()) {
    on<LoadApiHomeEvent>((event, emit) {
      emit(LoadApiHomeState());
    });
    on<SuccessApiHomeEvent>((event, emit) {
      emit(SuccessApiHomeState(
        listNomination: event.listNomination
      ));
    });
  }
}