
import 'package:dating/model/model_create_payment.dart';
import 'package:dating/model/model_response_list_pairing.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/model_unmatched_users.dart';

part 'premium_event.dart';
part 'premium_state.dart';

class PremiumBloc extends Bloc<PremiumEvent, PremiumState> {
  PremiumBloc() : super(SuccessPremiumState(resMatches: [], resEnigmatic: [])) {
    on<LoadPremiumEvent>((event, emit) {
      emit(LoadPremiumState());
    });
    on<SuccessPremiumEvent>((event, emit) {
      final currentState = state;
      if(currentState is SuccessPremiumState) {
        emit(SuccessPremiumState(
          resMatches: event.resMatches ?? currentState.resMatches,
          resEnigmatic: event.resEnigmatic ?? currentState.resEnigmatic,
          responsePayment: event.responsePayment ?? currentState.responsePayment,
        ));
      } else {
        emit(SuccessPremiumState(
          resMatches: event.resMatches,
          resEnigmatic: event.resEnigmatic,
          responsePayment: event.responsePayment
        ));
      }
    });
  }
}