import 'package:dating/argument_model/arguments_detail_model.dart';
import 'package:dating/bloc/bloc_premium/premium_bloc.dart';
import 'package:dating/common/format_amount.dart';
import 'package:dating/common/global.dart';
import 'package:dating/common/textstyles.dart';
import 'package:dating/model/model_create_payment.dart';
import 'package:dating/model/model_info_user.dart' as info_user;
import 'package:dating/model/model_is_check_new_state.dart';
import 'package:dating/model/model_response_list_pairing.dart';
import 'package:dating/model/model_unmatched_users.dart';
import 'package:dating/service/exception.dart';
import 'package:dating/service/service_match.dart';
import 'package:dating/service/service_payment.dart';
import 'package:dating/service/service_update.dart';
import 'package:dating/theme/theme_color.dart';
import 'package:dating/theme/theme_config.dart';
import 'package:dating/theme/theme_icon.dart';
import 'package:dating/tool_widget_custom/bottom_sheet_custom.dart';
import 'package:dating/tool_widget_custom/button_widget_custom.dart';
import 'package:dating/ui/detail/detail_screen.dart';
import 'package:dating/ui/message/view_chat_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../bloc/bloc_message/detail_message_bloc.dart';


class PremiumController {
  BuildContext context;
  PremiumController(this.context);

  ServiceMatch service = ServiceMatch();
  ServiceUpdate serviceUpdate = ServiceUpdate();
  ServicePayment servicePayment = ServicePayment();
  int idUser = Global.getInt(ThemeConfig.idUser);

  Future<void> getDataMatch() async {
    onLoad();
    await getMatches();
  }

  void getDataEnigmatic() {
    onLoad();
    getEnigmatic();
  }

  Future<void> getMatches() async {
    ModelResponseListPairing response = await service.listPairing(idUser);
    if(response.result == 'Success') {
      List<Matches> matches = response.matches ?? [];
      onSuccess(matches: matches);
    } else {
      onError();
    }
  }

  void getEnigmatic() async {
    ModelUnmatchedUsers response =  await service.listUnmatchedUsers(idUser);
    if(response.result == 'Success') {
      List<UnmatchedUsers> enigmatic = response.unmatchedUsers ?? [];
      onSuccess(enigmatic: enigmatic);
    } else {
      onError();
    }
  }

  void onLoad() {
    context.read<PremiumBloc>().add(LoadPremiumEvent());
  }

  void onSuccess({List<Matches>? matches, List<UnmatchedUsers>? enigmatic, ModelCreatePayment? responsePayment}) {
    context.read<PremiumBloc>().add(SuccessPremiumEvent(
      resMatches: matches,
      resEnigmatic: enigmatic,
      responsePayment: responsePayment
    ));
  }

  void onError() {}

  void gotoDetail(SuccessPremiumState state, int index) async {
    final dataInfo = state.resMatches?[index].info;
    final dataListImage = state.resMatches?[index].listImage;
    final dataInfoMore = state.resMatches?[index].infoMore;

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
    await Navigator.pushNamed(context, DetailScreen.routeName,
      arguments: ArgumentsDetailModel(
        idUser: state.resMatches?[index].idUser,
        info: info,
        infoMore: infoMore,
        listImage: listImage,
        keyHero: index,
        notFeedback: false
      )
    );
    await Future.delayed(const Duration(milliseconds: 500));
    isCheckNewState(state.resMatches?[index].idUser ?? 0, state, index);
  }

  Future<void> isCheckNewState(int keyMatchValue, SuccessPremiumState state, int index) async {
    ModelIsCheckNewState req = ModelIsCheckNewState(keyMatch: keyMatchValue, idUser: idUser);
    final response = await serviceUpdate.checkNewState(req);
    if(response is Success<void, Exception>) {
      getMatches();
      getEnigmatic();
    } else if (response is Failure<void, Exception>){
      final error = response.exception;
      if (kDebugMode) print(error);
    }
  }

  void getGotoViewChat(SuccessPremiumState state, int index) async {
    final dataInfo = state.resMatches?[index].info;
    final list = state.resMatches?[index].listImage;
    final dataInfoMore = state.resMatches?[index].infoMore;
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
    for(int i=0; i< list!.length; i++) {
      listImage.add(info_user.ListImage(
        image: list[i].image,
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
    if(context.mounted) context.read<DetailMessageBloc>().add(DetailMessageEvent(response: []));
    await Navigator.pushNamed(context, ViewChatScreen.routeName, arguments: ArgumentsDetailModel(
        keyHero: 0,
        idUser: state.resMatches?[index].idUser,
        info: info,
        listImage: listImage,
        infoMore: infoMore,
        notFeedback: false
    ));
    await Future.delayed(const Duration(milliseconds: 500));
    isCheckNewState(state.resMatches?[index].idUser ?? 0, state, index);
  }

  void popupPayment(int amount, String url) {
    BottomSheetCustom.showCustomBottomSheet(context,
      backgroundColor: ThemeColor.blackColor,
      circular: 0,
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: IntrinsicHeight(
          child: Column(
            children: [
              Divider(color: ThemeColor.blackColor.withOpacity(0.1)),
              SizedBox(height: 20.w),
              Row(
                children: [
                  Image.asset(ThemeIcon.iconApp, height: 50.w, width: 50.w, fit: BoxFit.cover),
                  SizedBox(width: 20.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Date date premium', style: TextStyles.defaultStyle.bold.setColor(ThemeColor.whiteColor).setTextSize(17.sp)),
                      Text('Date date - make friends and date', style: TextStyles.defaultStyle.setColor(ThemeColor.whiteColor))
                    ],
                  )
                ],
              ),
              SizedBox(height: 20.w),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: Text(
                    'Start date today', style: TextStyles.defaultStyle.bold.setColor(ThemeColor.whiteColor),
                  )),
                  Expanded(child: Text(
                    '${formatAmount(amount)}VNĐ\n+vat', style: TextStyles.defaultStyle.setColor(ThemeColor.whiteColor),
                    textAlign: TextAlign.end,
                  ))
                ],
              ),
              Divider(color: ThemeColor.whiteColor.withOpacity(0.3)),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5.w),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.asset(ThemeIcon.iconVnpay, height: 40, width: 40, fit: BoxFit.cover)
                    ),
                    SizedBox(width: 20.w),
                    Text('Vnpay e-wallet', style: TextStyles.defaultStyle.setColor(ThemeColor.whiteColor))
                  ],
                ),
              ),
              Divider(color: ThemeColor.blackColor.withOpacity(0.3)),
              const Spacer(),
              ButtonWidgetCustom(
                textButton: 'register',
                color: ThemeColor.whiteColor,
                radius: 100.w,
                styleText: TextStyles.defaultStyle.bold.setColor(ThemeColor.blackColor),
                onTap: () => _actionUrlToViewWeb(url)
              )
            ],
          ),
        ),
      )
    );
  }

  void getUrlPayment() async {
    final response = await servicePayment.create();
    if(response is Success<ModelCreatePayment, Exception>) {
      if(response.value.amount != null) {
        ModelCreatePayment data = response.value;
        onSuccess(responsePayment: data);
        popupPayment(response.value.amount??0, response.value.source??'');
      } else {
        onError();
      }
    }
  }

  void _actionUrlToViewWeb(url) async {
    final action = Uri.parse(url);
    await launchUrl(action);
  }
}