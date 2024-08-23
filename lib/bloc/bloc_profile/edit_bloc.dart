

import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/model_info_user.dart';

part 'edit_event.dart';
part 'edit_state.dart';

class EditBloc extends Bloc<EditEvent, EditState> {
  EditBloc() : super(EditState()) {
    on<EditEvent>((event, emit) {
      emit(EditState(
        imageUpload: event.imageUpload ?? state.imageUpload,
        indexPurpose: event.indexPurpose ?? state.indexPurpose,
        purposeValue: event.purposeValue ?? state.purposeValue,
        indexLevel: event.indexLevel ?? state.indexLevel,
        modelInfoUser: event.modelInfoUser ?? state.modelInfoUser,
        isLoading: event.isLoading ?? state.isLoading,
      ));
    });
  }
}