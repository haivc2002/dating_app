

import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'edit_event.dart';
part 'edit_state.dart';

class EditBloc extends Bloc<EditEvent, EditState> {
  EditBloc() : super(EditState()) {
    on<EditEvent>((event, emit) {
      emit(EditState(
        imageUpload: event.imageUpload ?? state.imageUpload,
        indexPurpose: event.indexPurpose ?? state.indexPurpose,
        purposeValue: event.purposeValue ?? state.purposeValue,
      ));
    });
  }
}