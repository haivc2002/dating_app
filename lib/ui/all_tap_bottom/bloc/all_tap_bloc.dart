

import 'package:flutter_bloc/flutter_bloc.dart';

part 'all_tap_event.dart';
part 'all_tap_state.dart';

class AllTapBloc extends Bloc<AllTapEvent, AllTapState> {
  AllTapBloc() : super(AllTapState(selectedIndex: 0)) {
    on<AllTapEvent>((event, emit) {
      emit(AllTapState(selectedIndex: event.selectedIndex));
    });
  }
}