

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/model_base.dart';

part 'api_register_event.dart';
part 'api_register_state.dart';

class ApiRegisterBloc extends Bloc<ApiRegisterEvent, ApiRegisterState> {
  ApiRegisterBloc() : super(ApiRegisterState()) {
    on<ApiRegisterEvent>((event, emit) {
      emit(ApiRegisterState(a: event.a));
    });
    on<LoadApiRegisterEvent>((event, emit) {
      emit(LoadApiRegisterState());
    });
    on<SuccessApiRegisterEvent>((event, emit) {
      emit(SuccessApiRegisterState(
        response: event.response,
        a: state.a,
      ));
    });
  }
}

