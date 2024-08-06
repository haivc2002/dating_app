import 'package:dating/model/model_info_user.dart';

class UpdateModel {
  static ModelInfoUser modelInfoUser = ModelInfoUser();

  static void updateModelInfo(ModelInfoUser state, {
    String? name,
    String? academicLevel,
    String? desiredState,
    String? describeYourself,
    String? work,
    List<ListImage>? listImage,

    int? height,
    String? hometown,
    String? religion,
    String? smoking,
    String? wine,
    String? zodiac,
  }) {
    modelInfoUser = ModelInfoUser(
      idUser: state.idUser,
      message: state.message,
      result: state.result,
      email: state.email,
      info: Info(
        idUser: int.parse(state.idUser),
        gender: state.info?.gender,
        premiumState: state.info?.premiumState,
        birthday: state.info?.birthday,
        lat: state.info?.lat,
        lon: state.info?.lon,
        academicLevel: academicLevel ?? state.info?.academicLevel,
        name: name ?? state.info?.name,
        desiredState: desiredState ?? state.info?.desiredState,
        describeYourself: describeYourself == '' ? null : describeYourself ?? state.info?.describeYourself,
        word: work == '' ? null : work ?? state.info?.word,
      ),
      listImage: listImage ?? state.listImage,
      infoMore: InfoMore(
        idUser: state.infoMore?.idUser,

        height: height ?? state.infoMore?.height,
        hometown: hometown ?? state.infoMore?.hometown,
        religion: religion ?? state.infoMore?.religion,
        smoking: smoking ?? state.infoMore?.smoking,
        wine: wine ?? state.infoMore?.wine,
        zodiac: zodiac ?? state.infoMore?.zodiac,
      )
    );
  }
}
