
import 'package:flutter_bloc/flutter_bloc.dart';

part 'edit_more_state.dart';
part 'edit_more_event.dart';

class EditMoreBloc extends Bloc<EditMoreEvent, EditMoreState> {
  EditMoreBloc() : super(EditMoreState()) {
    on<EditMoreEvent>((event, emit) {
      emit(EditMoreState(
        smoking: event.smoking,
        wine: event.wine,
      ));
    });
  }
}