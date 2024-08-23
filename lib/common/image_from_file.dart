import 'package:dio/dio.dart';

import '../model/model_info_user.dart';

class ImageFromFile {
  static Future<FormData> format(ModelInfoUser model) async {
    final List<MultipartFile> listImage = await Future.wait(
      model.listImage?.where((image) => image.image != null && !image.image!.startsWith('http')).map((image) async {
        return MultipartFile.fromFile(
          image.image ?? '',
          filename: 'upload.jpg',
        );
      }).toList() ?? [],
    );

    final Map<String, dynamic> data = {
      'idUser': model.idUser,
      'email': model.email,
      'info': {
        'idUser': model.info?.idUser,
        'name': model.info?.name,
        'birthday': model.info?.birthday,
        'desiredState': model.info?.desiredState,
        'word': model.info?.word,
        'academicLevel': model.info?.academicLevel,
        'lat': model.info?.lat,
        'lon': model.info?.lon,
        'describeYourself': model.info?.describeYourself,
        'gender': model.info?.gender,
        'premiumState': model.info?.premiumState,
      },
      'listImage': listImage,
      'infoMore': {
        'idUser': model.infoMore?.idUser,
        'height': model.infoMore?.height,
        'wine': model.infoMore?.wine,
        'smoking': model.infoMore?.smoking,
        'zodiac': model.infoMore?.zodiac,
        'religion': model.infoMore?.religion,
        'hometown': model.infoMore?.hometown,
      },
    };

    return FormData.fromMap(data);
  }
}

