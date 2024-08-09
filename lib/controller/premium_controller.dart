import 'package:dating/bloc/bloc_premium/premium_bloc.dart';
import 'package:dating/common/global.dart';
import 'package:dating/model/model_response_list_pairing.dart';
import 'package:dating/service/service_match.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PremiumController {
  BuildContext context;
  PremiumController(this.context);

  ServiceMatch service = ServiceMatch();

  void getData() async {
    onLoad();
    int idUser = Global.getInt('idUser');
    ModelResponseListPairing response = await service.listPairing(idUser);
    if(response.result == 'Success') {
      List<Matches> matches = response.matches ?? [];
      onSuccess(matches);
    } else {
      onError();
    }
  }

  void onLoad() {
    context.read<PremiumBloc>().add(LoadPremiumEvent());
  }

  void onSuccess(List<Matches> response) {
    context.read<PremiumBloc>().add(SuccessPremiumEvent(response));
  }

  void onError() {}

}