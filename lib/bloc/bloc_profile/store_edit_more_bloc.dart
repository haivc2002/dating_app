
import 'package:flutter_bloc/flutter_bloc.dart';

part 'store_edit_more_state.dart';
part 'store_edit_more_event.dart';

class StoreEditMoreBloc extends Bloc<StoreEditMoreEvent, StoreEditMoreState> {
  StoreEditMoreBloc() : super(StoreEditMoreState(textEditingState: '')) {
    on<StoreEditMoreEvent>((event, emit) {
      emit(StoreEditMoreState(
        smoking: event.smoking ?? state.smoking,
        wine: event.wine ?? state.wine,
        zodiac: event.zodiac ?? state.zodiac,
        heightPerson: event.heightPerson ?? state.heightPerson,
        homeTown: event.homeTown ?? state.homeTown,
        character: event.character ?? state.character,
        textEditingState: event.textEditingState ?? state.textEditingState,
      ));
    });
  }
}