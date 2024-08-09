
import 'package:dating/model/model_response_list_pairing.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'premium_event.dart';
part 'premium_state.dart';

class PremiumBloc extends Bloc<PremiumEvent, PremiumState> {
  PremiumBloc() : super(LoadPremiumState()) {
    on<LoadPremiumEvent>((event, emit) {
      emit(LoadPremiumState());
    });
    on<SuccessPremiumEvent>((event, emit) {
      emit(SuccessPremiumState(response: event.response));
    });
  }
}