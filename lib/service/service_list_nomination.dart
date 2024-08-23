import 'package:dating/common/textstyles.dart';
import 'package:dating/model/model_list_nomination.dart';
import 'package:dating/service/url/api.dart';
import 'package:dating/theme/theme_color.dart';
import 'package:dating/tool_widget_custom/popup_custom.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ServiceListNomination {
  String url = Api.getNomination;

  late Dio dio;
  ServiceListNomination() {
    dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
  }
  
  Future<ModelListNomination> listNomination(BuildContext context,
      {int? idUser, String? gender, int? radius, int? limit, int? page}) async {
    final response = await dio.get('$url?idUser=$idUser&gender=$gender&radius=$radius&limit=$limit&page=$page');
    if(response.statusCode == 200) {
      return ModelListNomination.fromJson(response.data);
    } else {
      if(context.mounted) {
        PopupCustom.showPopup(
          context,
          content: const Text('The server is busy'),
          listOnPress: [()=> Navigator.pop(context)],
          listAction: [Text('Ok', style: TextStyles.defaultStyle.bold.setColor(ThemeColor.blueColor))]
        );
      }
      throw Exception('Failed to load data!');
    }
  }
}