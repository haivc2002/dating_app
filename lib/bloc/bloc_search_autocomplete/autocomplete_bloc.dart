

import 'package:dating/model/search_autocomplete_model/search_autocomplete_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'autocomplete_event.dart';
part 'autocomplete_state.dart';

class AutocompleteBloc extends Bloc<AutocompleteEvent, AutocompleteState> {
  AutocompleteBloc() : super(LoadAutocompleteState()) {
    on<LoadAutocompleteEvent>((event, emit) {
      emit(LoadAutocompleteState());
    });
    on<SuccessAutocompleteEvent>((event, emit) {
      emit(SuccessAutocompleteState(response: event.response));
    });
    on<ErrorAutocompleteEvent>((event, emit) {
      emit(ErrorAutocompleteState(message: event.message));
    });
  }
}