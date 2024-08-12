import 'package:swipable_stack/swipable_stack.dart';

import '../model/model_info_user.dart';

class ArgumentsDetailModel {
  int? keyHero;
  SwipableStackController? controller;
  int? idUser;
  List<ListImage>? listImage;
  Info? info;
  InfoMore? infoMore;
  bool? notFeedback;

  ArgumentsDetailModel({
    this.keyHero,
    this.controller,
    this.idUser,
    this.info,
    this.listImage,
    this.infoMore,
    this.notFeedback,
  });
}