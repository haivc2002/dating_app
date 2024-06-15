

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/location_model/location_current_model.dart';

part 'get_location_event.dart';
part 'get_location_state.dart';

class GetLocationBloc extends Bloc<GetLocationEvent, GetLocationState> {
  GetLocationBloc() : super(LoadGetLocationState()) {
    on<LoadGetLocationEvent>((event, emit) {
      emit(LoadGetLocationState());
    });
    on<SuccessGetLocationEvent>((event, emit) {
      emit(SuccessGetLocationState(response: event.response));
    });
  }
}