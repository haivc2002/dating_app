
import 'package:dating/model/model_base.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../common/textstyles.dart';
import '../model/model_request_image.dart';
import '../theme/theme_color.dart';
import '../tool_widget_custom/popup_custom.dart';
import 'url/api.dart';

class ServiceAddImage {
  String urlApiAddImage = Api.addImage;

  late Dio dio;
  ServiceAddImage() {
    dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
  }

  Future<ModelBase> addImage(ModelRequestImage req, BuildContext context) async {
    FormData formData = FormData.fromMap({
      'idUser': req.idUser,
      'image': await MultipartFile.fromFile(req.image!.path, filename: 'upload.jpg'),
    });
    final request = await dio.post(urlApiAddImage, data: formData);
    if(request.statusCode != 200) {
      if(context.mounted) {
        PopupCustom.showPopup(
            context,
            listOnPress: [()=> Navigator.pop(context)],
            listAction: [Text('Ok', style: TextStyles.defaultStyle.bold.setColor(ThemeColor.blueColor))]
        );
      }
      return ModelBase.fromJson(request.data);
    } else {
      return ModelBase.fromJson(request.data);
    }
  }
}