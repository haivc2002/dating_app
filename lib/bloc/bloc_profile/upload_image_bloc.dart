

import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'upload_image_event.dart';
part 'upload_image_state.dart';

class UploadImageBloc extends Bloc<UploadImageEvent, UploadImageState> {
  UploadImageBloc() : super(UploadImageState(isLoad: false)) {
    on<UploadImageEvent>((event, emit) {
      emit(UploadImageState(imageUpload: event.imageUpload, isLoad: event.isLoad));
    });
  }
}