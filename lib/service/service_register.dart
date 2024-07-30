import 'package:dating/common/textstyles.dart';
import 'package:dating/model/model_base.dart';
import 'package:dating/model/model_request_auth.dart';
import 'package:dating/model/model_request_image.dart';
import 'package:dating/service/url/api.dart';
import 'package:dating/theme/theme_color.dart';
import 'package:dating/tool_widget_custom/popup_custom.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../model/model_req_register_info.dart';

class ServiceRegister {
  String url = Api.register;
  String urlApiRegisterInfo = Api.registerInfo;

  late Dio dio;
  ServiceRegister() {
    dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
  }

  Future<ModelBase> register(ModelRequestAuth req, BuildContext context) async {
    final request = await dio.post(url, data: req.toJson());
    if(request.statusCode == 200) {
      return ModelBase.fromJson(request.data);
    } else {
      if(context.mounted) {
        PopupCustom.showPopup(context,
            content: Text('Error!', style: TextStyles.defaultStyle.setColor(ThemeColor.redColor)),
            listOnPress: [()=>Navigator.pop(context)],
            listAction: [Text('Ok', style: TextStyles.defaultStyle.setColor(ThemeColor.blueColor))]
        );
      }
      throw Exception('Failed to request data');
    }
  }

  Future<ModelBase> registerInfo(ModelReqRegisterInfo req, BuildContext context) async {
    final request = await dio.post(urlApiRegisterInfo, data: req.toJson());
    if(request.statusCode == 200) {
      return ModelBase.fromJson(request.data);
    } else {
      if(context.mounted) {
        PopupCustom.showPopup(context,
          content: Text('Error!', style: TextStyles.defaultStyle.setColor(ThemeColor.redColor)),
          listOnPress: [()=>Navigator.pop(context)],
          listAction: [Text('Ok', style: TextStyles.defaultStyle.setColor(ThemeColor.blueColor))]
        );
      }
      throw Exception('Failed to request data');
    }
  }

}