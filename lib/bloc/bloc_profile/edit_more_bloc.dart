
import 'package:flutter_bloc/flutter_bloc.dart';

part 'edit_more_state.dart';
part 'edit_more_event.dart';

class EditMoreBloc extends Bloc<EditMoreEvent, EditMoreState> {
  EditMoreBloc() : super(EditMoreState()) {
    on<EditMoreEvent>((event, emit) {
      emit(EditMoreState(
        smoking: event.smoking ?? state.smoking,
        wine: event.wine ?? state.wine,
        zodiac: event.zodiac ?? state.zodiac,
        heightPerson: event.heightPerson ?? state.heightPerson,
        homeTown: event.homeTown ?? state.homeTown,
        character: event.character ?? state.character,
      ));
    });
  }
}