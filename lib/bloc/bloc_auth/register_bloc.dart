

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';

import '../../model/model_base.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterState(appBarHeightFactor: 0.35)) {
    on<RegisterEvent>((event, emit) {
      emit(RegisterState(
        appBarHeightFactor: event.appBarHeightFactor ?? state.appBarHeightFactor,
        indexItemGender: event.indexItemGender ?? state.indexItemGender,
        blurValue: event.blurValue ?? state.blurValue,
        remainingTime: event.remainingTime ?? state.remainingTime,
        fileRive: event.fileRive ?? state.fileRive,
        birthdayValue: event.birthdayValue ?? state.birthdayValue,
        desiredState: event.desiredState ?? state.desiredState,
        genderValue: event.genderValue ?? state.genderValue,
        lon: event.lon ?? state.lon,
        lat: event.lat ?? state.lat,
      ));
    });
  }
}