import 'package:dating/argument_model/arguments_detail_model.dart';
import 'package:dating/bloc/bloc_premium/premium_bloc.dart';
import 'package:dating/common/global.dart';
import 'package:dating/model/model_response_list_pairing.dart';
import 'package:dating/service/service_match.dart';
import 'package:dating/ui/detail/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dating/model/model_info_user.dart' as info_user;

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

  void gotoDetail(SuccessPremiumState state, int index) {
    final dataInfo = state.response[index].info;
    final dataListImage = state.response[index].listImage;
    final dataInfoMore = state.response[index].infoMore;

    info_user.Info info = info_user.Info(
      lon: dataInfo?.lon,
      lat: dataInfo?.lat,
      name: dataInfo?.name,
      word: dataInfo?.word,
      describeYourself: dataInfo?.describeYourself,
      birthday: dataInfo?.birthday,
      academicLevel: dataInfo?.academicLevel,
      desiredState: dataInfo?.desiredState,
    );

    List<info_user.ListImage> listImage = [];
    for(int i=0; i< dataListImage!.length; i++) {
      listImage.add(info_user.ListImage(
        image: dataListImage[i].image,
      ));
    }

    info_user.InfoMore infoMore = info_user.InfoMore(
        hometown: dataInfoMore?.hometown,
        height: dataInfoMore?.height,
        zodiac: dataInfoMore?.zodiac,
        smoking: dataInfoMore?.smoking,
        wine: dataInfoMore?.wine,
        religion: dataInfoMore?.religion
    );

    Navigator.pushNamed(context, DetailScreen.routeName,
      arguments: ArgumentsDetailModel(
        idUser: state.response[index].idUser,
        info: info,
        infoMore: infoMore,
        listImage: listImage,
        keyHero: index,
        notFeedback: false
      )
    );
  }

}